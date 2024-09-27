using Microsoft.Data.SqlClient;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace UMC.Estimator.AdoDBContext.DatabaseConnection
{
    public class EstimatorDBContext
    {
        private static readonly string? connectionString;
        static EstimatorDBContext()
        {
            connectionString = DatabaseConnection.connectionString;
        }
        public static async Task<DataSet> GetDataAsync(string storedProcedureName, object[] parameters, object[] values)
        {
            DataSet dataSet = new DataSet();
            try
            {
                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    using (SqlCommand cmd = new SqlCommand(storedProcedureName, con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        await con.OpenAsync();

                        // Using for loop to set parameter names and values for stored procedure
                        for (int i = 0; i < parameters.Length; i++)
                        {
                            string parameter = Convert.ToString(parameters[i]);
                            string value = Convert.ToString(values[i]);
                            cmd.Parameters.AddWithValue(parameter, value);
                        }

                        using (SqlDataAdapter sqlDataAdapter = new SqlDataAdapter(cmd))
                        {
                            await Task.Run(() => sqlDataAdapter.Fill(dataSet));
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex);
            }
            return dataSet;
        }

        public static async Task<long?> InsertUpdateDataAsync(string spName, object[] parameters, object[] values, object[] sqlDbTypes)
        {
            long? id = null;
            try
            {
                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    using (SqlCommand cmd = new SqlCommand(Convert.ToString(spName), con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        await con.OpenAsync();

                        // Using for loop to set parameter names and values for the stored procedure
                        for (int i = 0; i < parameters.Length; i++)
                        {
                            string parameter = Convert.ToString(parameters[i]);
                            string value = Convert.ToString(values[i]);
                            SqlDbType sqlDbType = (SqlDbType)Enum.Parse(typeof(SqlDbType), sqlDbTypes[i].ToString());
                            SqlParameter tvpParam = cmd.Parameters.AddWithValue(parameter, value);
                            tvpParam.SqlDbType = sqlDbType;
                        }

                        object statusId = await cmd.ExecuteScalarAsync();
                        if (statusId != null)
                        {
                            id = Convert.ToInt64(statusId);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex);
            }
            return id;
        }

    }
}
