using System;
using System.Threading;
using System.Threading.Tasks;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;

namespace aspnet_core_dotnet_core.Services
{
    public class ServiceB : BackgroundService
    {
        public ServiceB(ILoggerFactory loggerFactory)
        {
            Logger = loggerFactory.CreateLogger<ServiceB>();
        }

        public ILogger Logger { get; }

        protected override async Task ExecuteAsync(CancellationToken stoppingToken)
        {
            Logger.LogInformation("ServiceB is starting.");

            stoppingToken.Register(() => Logger.LogInformation("ServiceB is stopping."));

            Logger.LogInformation("ServiceB has stopped.");
        }
    }
}
