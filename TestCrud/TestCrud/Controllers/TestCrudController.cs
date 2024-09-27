using DatabaseConnection;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;
using System.ComponentModel.DataAnnotations;
using System.Data;
using TestCrud.Models;
using TestCrud.Repository;

namespace TestCrud.Controllers
{
    public class TestCrudController : Controller
    {
        private readonly IMasterRepository _masterRepository;
        public TestCrudController(IMasterRepository masterRepository)
        {
            _masterRepository = masterRepository;
        }
        public IActionResult Index()
        {
            try
            {
                string query = $"select * from \"Public\".get_user_ref(cursordata=>'data', actiontype=>'getAlluser');";
                DataSet data = _masterRepository.GetAndSelectTableItems(query);

                ViewBag.Users = CommonMethod.checkDataSet(data);
            }
            catch (Exception e)
            {
                Log.LogError(e);
            }
            return View();
        }
        public IActionResult CreateAndUpdate(int? id)
        {
            try
            {
                string query = string.Empty;
                
                string CountryQuery = $"select * from  \"Public\".get_statecitybyid_ref(actiontype := 'getall_country',cursordata :='data');";
                DataSet CountryDS = _masterRepository.GetAndSelectTableItems(CountryQuery);
                ViewBag.Countries = CommonMethod.checkDataSet(CountryDS);
                if (id != null || id != 0)
                {
                    string getUserQuery = $"select * from \"Public\".get_user_ref(cursordata=>'data', actiontype=>'getuserbyid', _id=>{id});";
                    DataSet getUserDS = _masterRepository.GetAndSelectTableItems(getUserQuery);
                    DataSet checkData = CommonMethod.checkDataSet(getUserDS);
                    if (checkData != null)
                    {
                        DataRow Row = checkData.Tables[0].Rows[0];
                        string hobbiesString = Convert.ToString(Row["hobby"]);
                        List<string> hobbiesList = hobbiesString.Split(new[] { ',' }, StringSplitOptions.RemoveEmptyEntries)
                                            .Select(s => s.Trim())
                                            .ToList();
                        ViewBag.hobbiesList = hobbiesList;
                        ViewBag.password = Convert.ToString(Row["password"]);
                        ViewBag.stateId = Convert.ToString(Row["state_id"]);
                        ViewBag.cityId = Convert.ToString(Row["city_id"]);
                        ViewBag.countryId = Convert.ToString(Row["country_id"]);
                        User user = new User()
                        {
                            FullName = Convert.ToString(Row["full_name"]),
                            Email = Convert.ToString(Row["email"]),
                            Password = Convert.ToString(Row["password"]),
                            Gender = Convert.ToString(Row["gender"]),
                            Hobbies = hobbiesList,
                            DateOfBirth = Convert.ToDateTime(Row["date_of_birth"]),
                            Address = Convert.ToString(Row["address"]),
                            City = Convert.ToString(Row["city"]),
                            State = Convert.ToString(Row["state"]),
                            Country = Convert.ToString(Row["country"]),
                            Id = Convert.ToInt32(Row["id"])

                        };
                        return View(user);

                    }
                }
            }
            catch(Exception e)
            {
                Log.LogError(e);
            }
            return View();
        }
        [HttpPost]
        public IActionResult CreateAndUpdate(User model)
        {
            try
            {
                if(model.Id == null || model.Id <= 0 )
                {
                    model.Id = 0;   
                }
                string Hobbies = model.Hobbies != null ? string.Join(", ", model.Hobbies) : "N/A";
                string query = $"select * from \"Public\".user_createupdate_delete_ref(cursordata=>'data', actiontype =>'insertupdateuser', _id=>{model.Id}, _email=>'{model.Email}', _password=>'{model.Password}', _full_name=>'{model.FullName}', _gender=>'{model.Gender}', _date_of_birth=>'{model.DateOfBirth}', _address=>'{model.Address}', _city_id=>{model.City}, _hobby=>'{Hobbies}');";
                DataSet data = _masterRepository.GetAndSelectTableItems(query);
                DataSet CheckData = CommonMethod.checkDataSet(data);
                if (CheckData != null)
                {
                    int statusCode = Convert.ToInt32(data.Tables[0].Rows[0]["status_code"]);
                    string message = Convert.ToString(data.Tables[0].Rows[0]["result_message"]);
                    if (statusCode == 1)
                    {
                        TempData["Success"] = message;
                    }
                    else if (statusCode == 2)
                    {
                        TempData["Success"] = message;
                    }
                }
            }
            catch (Exception e)
            {
                Log.LogError(e);
            }
            return RedirectToAction("Index");
        }
        public IActionResult getStateCityByID(int id, string type)
        {
            try
            {
                
                string query = string.Empty;
                //get stet by country id query
                if (type == "Country")
                {
                    query = $"select * from  \"Public\".get_statecitybyid_ref(actiontype := 'get_statebycountryid', cursordata :='data',_id:={id});";
                }
                if (type == "State")
                {
                    query = $"select * from  \"Public\".get_statecitybyid_ref(actiontype := 'get_citybystateid', cursordata :='data',_id:={id});";
                }
                DataSet data = _masterRepository.GetAndSelectTableItems(query);
                string jsonData = JsonConvert.SerializeObject(data.Tables[0]);
                return Json(new { data = jsonData, success = true });
            }
            catch (Exception e)
            {
                Log.LogError(e);
                return Json(new { success = false, message = e.Message });
            }
        }
        public IActionResult deleteUser(int? id)
        {
            try
            {
                string Query = $"select * from \"Public\".user_createupdate_delete_ref(cursordata=>'data', actiontype =>'deleteuser', _id=>{id});";
                DataSet data = _masterRepository.GetAndSelectTableItems(Query);
                DataSet CheckData = CommonMethod.checkDataSet(data);
                if (CheckData != null)
                {
                    int statusCode = Convert.ToInt32(data.Tables[0].Rows[0]["status_code"]);
                    string message = Convert.ToString(data.Tables[0].Rows[0]["result_message"]);
                    if (statusCode == 3)
                    {
                        TempData["Success"] = message;
                    }
                }
                string jsonData = JsonConvert.SerializeObject(data.Tables[0]);
                return Json(new { data = jsonData, success = true });
            }
            catch(Exception e)
            {
                Log.LogError(e);
                return Json(new { success = false, message = e.Message });
            }
        }
    }
}