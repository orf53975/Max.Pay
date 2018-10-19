﻿using Autofac;
using log4net;
using System;
using Topshelf;
using Topshelf.Autofac;

namespace Max.Job.QianTu
{
    class Program
    {
        private static ILog log = LogManager.GetLogger(typeof(Program));
        private static IContainer container;

        static void Main(string[] args)
        {
            try
            {
                container = JobConfig.ConfigureContainer(new ContainerBuilder()).Build();

                HostFactory.Run(config =>
                {
                    config.SetServiceName(JobConfig.ServiceName);
                    config.UseLog4Net();
                    config.UseAutofacContainer(container);

                    config.Service<JobService>((svc) =>
                    {
                        svc.ConstructUsingAutofacContainer();
                        svc.WhenStarted(o => o.Start());
                        svc.WhenStopped(o =>
                        {
                            o.Stop();
                            container.Dispose();
                        });

                        JobConfig.Schedule(container, svc);
                    });
                });

                log4net.LogManager.Shutdown();
            }
            catch (Exception ex)
            {
                log.Error(ex.ToString());
                log4net.LogManager.Shutdown();
            }
        }
    }
}
