using System.Data;

namespace TestCrud.Repository
{
    public interface IMasterRepository
    {
       public DataSet GetAndSelectTableItems(string sqlQuery);
    }
    
}
