
using TestCrud.Repository;

var builder = WebApplication.CreateBuilder(args);
DatabaseConnection.DatabaseConnection.connectionString = builder.Configuration.GetConnectionString("Connection");
// Add services to the container.
builder.Services.AddControllersWithViews();
//add dependency
builder.Services.AddScoped<IMasterRepository, MasterRepository>();
var app = builder.Build();

// Configure the HTTP request pipeline.
if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Home/Error");
    // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
    app.UseHsts();
}
DatabaseConnection.RootDirectoryPath.ContentRootPath = app.Environment.ContentRootPath;
app.UseHttpsRedirection();
app.UseStaticFiles();

app.UseRouting();

app.UseAuthorization();

app.MapControllerRoute(
    name: "default",
    //pattern: "{controller=Home}/{action=Index}/{id?}");
    pattern: "{controller=TestCrud}/{action=Index}/{id?}");

app.Run();
