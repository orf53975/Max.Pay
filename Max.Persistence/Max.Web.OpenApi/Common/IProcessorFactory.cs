﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Max.Web.OpenApi.Common
{
    public interface IProcessorFactory
    {
        IProcessor Create(string bizCode);
    }
}
