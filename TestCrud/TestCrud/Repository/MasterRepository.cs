using System.Data;
using TestCrud.Repository;
using DatabaseConnection;

namespace TestCrud.Repository
{
    public class MasterRepository : IMasterRepository
    {
       
       public DataSet GetAndSelectTableItems(string sqlQuery)
        {
            DataSet data = new DataSet();
            try
            {

                data = DatabaseConnection.TestCrudDBContext.GetData(sqlQuery);
            }
            catch (Exception e)
            {
                data = null;
               Log.LogError(e);
            }
            return data;
        }
    }
}
