using Microsoft.AspNetCore.Builder;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using SoapCore;
using EquipoNatacionService.Services;
using EquipoNatacionService.Data;
using Microsoft.EntityFrameworkCore;

var builder = WebApplication.CreateBuilder(args);

// add services to the container
builder.Services.AddControllers();
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

// configure EF Core with Oracle ( connection string in appsettings.json )
builder.Services.AddDbContext<OracleDbContext>(options =>
    options.UseOracle(builder.Configuration.GetConnectionString("OracleConnection"))
);

// register SOAP service
builder.Services.AddSingleton<IEquipoService, EquipoService>();


