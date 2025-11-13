using Microsoft.AspNetCore.Builder;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using SoapCore;
using EquipoNatacionService.Services;
using EquipoNatacionService.Data;
using Microsoft.EntityFrameworkCore;

var builder = WebApplication.CreateBuilder(args);

// ----------------------------------------------------------------------
// 🔧 Servicios
// ----------------------------------------------------------------------
builder.Services.AddControllers();
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

// 🔗 Configurar EF Core con Oracle
builder.Services.AddDbContext<OracleDbContext>(options =>
    options.UseOracle(builder.Configuration.GetConnectionString("OracleConnection"))
);

// 🧩 Registrar el servicio SOAP
builder.Services.AddScoped<IEquipoService, EquipoService>();

// ----------------------------------------------------------------------
// 🚀 Construir aplicación
// ----------------------------------------------------------------------
var app = builder.Build();

// ----------------------------------------------------------------------
// 🌐 Middleware
// ----------------------------------------------------------------------
if (app.Environment.IsDevelopment())
{
    app.UseDeveloperExceptionPage();
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseRouting();
app.UseHttpsRedirection();
app.UseAuthorization();

// ----------------------------------------------------------------------
// 🧼 Endpoint SOAP
// ----------------------------------------------------------------------
// Esto expone el servicio SOAP en: http://localhost:5190/EquipoService.svc
app.UseEndpoints(endpoints =>
{
    endpoints.UseSoapEndpoint<IEquipoService>(
        "/EquipoService.svc",
        new SoapEncoderOptions(),
        SoapSerializer.DataContractSerializer
    );

    endpoints.MapControllers();
});

// ----------------------------------------------------------------------
// ▶️ Iniciar aplicación
// ----------------------------------------------------------------------
app.Run();
