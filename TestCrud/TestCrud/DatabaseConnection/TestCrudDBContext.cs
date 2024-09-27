
using Npgsql;
using System.Data;

namespace DatabaseConnection
{
    public class TestCrudDBContext
    {
        private static readonly string connectionString;
        static TestCrudDBContext()
        {
            //Get connection string for appsettings.json file and set into global variable.
            connectionString = DatabaseConnection.connectionString;
        }

        public static DataSet GetData(string SqlQuery, int timeOut = 3000)
        {
            DataSet dataSet = new DataSet();
            try
            {
                using (NpgsqlConnection conn = new NpgsqlConnection(connectionString))
                {
                    if (conn.State == ConnectionState.Closed)
                    {
                        conn.Open();
                    }
                    using (NpgsqlCommand command = new NpgsqlCommand(SqlQuery, conn))
                    {
                        NpgsqlTransaction tran = conn.BeginTransaction();
                        command.CommandText = SqlQuery;
                        command.CommandTimeout = timeOut;
                        command.Connection = conn;
                        command.CommandType = CommandType.Text;
                        command.Transaction = tran;
                        string cursorName = (string)command.ExecuteScalar();

                        dataSet = FetchResultFromCursorDataset(cursorName, conn);
                        tran.Commit();
                    }
                }
                return dataSet;
            }
            catch (Exception ex)
            {
               Log.LogError(ex);
            }
            return dataSet;
        }

        static DataSet FetchResultFromCursorDataset(string cursorName, NpgsqlConnection connection)
        {
            DataSet dsResult = new DataSet();
            try
            {
                using (NpgsqlCommand command = new NpgsqlCommand())
                {
                    command.Connection = connection;
                    command.CommandText = "fetch all in \"" + cursorName + "\";";
                    command.CommandType = CommandType.Text;

                    using (NpgsqlDataAdapter adapter = new NpgsqlDataAdapter(command))
                    {
                        adapter.Fill(dsResult);
                    }
                }
            }
            catch (Exception ex)
            {
                Log.LogError(ex);
            }
            return dsResult;
        }

    }
}