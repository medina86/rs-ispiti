using eCommerce.Services;
using eCommerce.Services.Database;
using eCommerce.Services.ProductStateMachine;
using eCommerce.WebAPI.Filters;
using Mapster;
using MapsterMapper;
using Microsoft.AspNetCore.Authentication;
using Microsoft.OpenApi.Models;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddTransient<IProductService, ProductService>();
builder.Services.AddTransient<IUserService, UserService>();
builder.Services.AddTransient<IProductTypeService, ProductTypeService>();
builder.Services.AddTransient<IRoleService, RoleService>();
builder.Services.AddTransient<IUnitOfMeasureService, UnitOfMeasureService>();
builder.Services.AddTransient<IToDoService, ToDoService>();

builder.Services.AddTransient<BaseProductState>();
builder.Services.AddTransient<InitialProductState>();
builder.Services.AddTransient<DraftProductState>();
builder.Services.AddTransient<ActiveProductState>();
builder.Services.AddTransient<DeactivatedProductState>();

builder.Services.AddMapster();
// Configure database
var connectionString = builder.Configuration.GetConnectionString("DefaultConnection") ?? "Server=localhost;Database=eCommerceDb;Trusted_Connection=True;MultipleActiveResultSets=true;TrustServerCertificate=True";
builder.Services.AddDatabaseServices(connectionString);
builder.Services.AddAuthentication("BasicAuthentication")
    .AddScheme<AuthenticationSchemeOptions, BasicAuthenticationHandler>("BasicAuthentication", null);


builder.Services.AddControllers( x=> 
    {
        x.Filters.Add<ExceptionFilter>();
    }
);
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen(c =>
{
    c.AddSecurityDefinition("BasicAuthentication", new OpenApiSecurityScheme
    {
        Name = "Authorization",
        Type = SecuritySchemeType.Http,
        Scheme = "basic",
        In = ParameterLocation.Header,
        Description = "Basic Authorization header using the Bearer scheme."
    });
    c.AddSecurityRequirement(new OpenApiSecurityRequirement
    {
        {
            new OpenApiSecurityScheme { Reference = new OpenApiReference { Type = ReferenceType.SecurityScheme, Id = "BasicAuthentication" } },
            new string[] { }
        }
    });
});


var app = builder.Build();

using (var scope = app.Services.CreateScope())
{
var dbContext = scope.ServiceProvider.GetRequiredService<eCommerceDbContext>();
dbContext.Database.EnsureCreated();
    if (!dbContext.Roles.Any())
    {
        var roleservice = scope.ServiceProvider.GetRequiredService<IRoleService>();
        await roleservice.CreateAsync(new eCommerce.Model.Requests.RoleUpsertRequest()
        {
            Name = "Admin",
            Description = "Superadmin",
            IsActive = true
        });

        var userservice = scope.ServiceProvider.GetRequiredService<IUserService>();
        await userservice.CreateAsync(new eCommerce.Model.Requests.UserUpsertRequest()
        {
            IsActive = true,
            Email = "admin@gmail,com",
            FirstName = "Medina",
            LastName = "Krhan",
            Password = "qwertz",
            PhoneNumber = "38766626626",
            Username = "medina",
            RoleIds = new List<int> { 1 }
        });
        var todos = scope.ServiceProvider.GetRequiredService<IToDoService>();
        await todos.CreateAsync(new eCommerce.Model.Requests.ToDoRequest()
        {
            Naziv = "Naziv",
            Opis = "Opis",
            Rok = DateTime.UtcNow,
            Status = eCommerce.Model.Enums.StatusAktivnosti.UToku,
            UserId = 1
        });
    }
}

//if (app.Environment.IsDevelopment())

    app.UseSwagger();
    app.UseSwaggerUI();



app.UseAuthorization();

app.MapControllers();

app.Run();
