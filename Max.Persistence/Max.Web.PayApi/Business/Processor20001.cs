﻿using Max.Framework.DAL;
using Max.Web.PayApi.Business.Request;
using Max.Web.PayApi.Business.Response;
using Max.Web.PayApi.Common;
using Max.Framework;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using log4net;
using Max.Service.Payment;
using System.ComponentModel;

namespace Max.Web.PayApi.Business
{
    /// <summary>
    /// 订单查询
    /// </summary>
    [Description("huizongpay")]
    public class Processor20001 : IProcessor
    {
        private static ILog log = LogManager.GetLogger(typeof(Processor20001));
        private PayOrderService _payOrderService;
        private MerchantService _merchantService;
        public Processor20001(PayOrderService payOrderService, MerchantService merchantService)
        {
            this._payOrderService = payOrderService;
            this._merchantService = merchantService;
        }


        public BaseResponse Process(BaseRequest baseRequest)
        {

            return BaseResponse.Create(ApiEnum.ResponseCode.处理失败, "查无此订单");


        }


    }
}