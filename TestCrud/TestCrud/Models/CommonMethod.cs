using System.Data;

namespace TestCrud.Models
{
    public class CommonMethod
    {
        public static DataSet checkDataSet(DataSet dataset)
        {
            try
            {
                if(dataset!=null && dataset.Tables.Count > 0 && dataset.Tables[0].Rows.Count > 0)
                {
                    return dataset;
                }
                else
                {
                    return null;
                }
            }
            catch(Exception e) 
            {
                return null;
            }
        }
    }
}
