﻿using System.Text;
using System.Web.Mvc;
using Max.Framework;
using Max.Web.Presentation.Infrastructure.Razor;
using Max.Web.Presentation.Helpers;

namespace Max.Web.Presentation.Controllers
{
    public abstract class BaseController : Controller
    {

        protected ActionResult RedirectToLocal(string returnUrl)
        {
            if (Url.IsLocalUrl(returnUrl))
            {
                return Redirect(returnUrl);
            }
            return RedirectToAction("Index", "Home");
        }

        public new ContentResult Json(object data)
        {
            return Content(data.ToJson(), "application/json");
        }

        public ActionResult PageView<TModel, TParam>(Query<TModel, TParam> model)
            where TParam : new()
        {
            if (model.__defaultView)
                return View(model);

            if (Request.IsAjaxRequest())
                return PartialView(model.__partialView, model);

            return View(model);
        }

        public ActionResult PageView<TModel, TParam>(string viewName, Query<TModel, TParam> model)
            where TParam : new()
        {
            if (model.__defaultView)
                return View(viewName, model);

            if (Request.IsAjaxRequest())
                return PartialView(model.__partialView, model);

            return View(viewName, model);
        }

        public ActionResult AjaxView<TModel>(string viewName, TModel model)
        {
            if (Request.IsAjaxRequest())
                return PartialView(viewName, model);
            return View(model);
        }

        /// <summary>
        /// 将ModelState错误消息汇总
        /// </summary>
        /// <returns></returns>
        protected string GetModelStateMessage()
        {
            StringBuilder builder = new StringBuilder();
           
            //获取每一个key对应的ModelStateDictionary
            foreach (var key in ModelState.Keys)
            {
                var errors = ModelState[key].Errors;
                //将错误描述添加到 StringBuilder 中
                foreach (var error in errors)
                {
                    builder.Append(error.ErrorMessage);
                    builder.Append("<br/>");
                }
            }
            return builder.ToString();
        }

        /// <summary>
        /// 当前用户Id
        /// </summary>
        public string UserId
        {
            get { return WapAuthorizeHelper.GetCurrentUserId(); }
        }
    }
}