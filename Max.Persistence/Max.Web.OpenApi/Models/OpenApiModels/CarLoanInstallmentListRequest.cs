﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Max.Web.OpenApi.Models.OpenApiModels
{
    /// <summary>
    /// 进件还款信息查询
    /// </summary>
    public class CarLoanInstallmentListRequest
    {

        /// <summary>
        /// 钱端订单号列表，提交进件申请通过后由钱端系统返回
        /// </summary>
        public List<string> QueryList { get; set; }
    }


}
