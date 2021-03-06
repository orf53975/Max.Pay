﻿using Max.Framework;
using Max.Framework.Authorization;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Text.RegularExpressions;
using System.Web.Mvc.Html;
using System.Linq.Expressions;
using System.Collections.Concurrent;
using System.Text;
using System.Reflection;
using Max.Framework.Expressions;
using System.ComponentModel.DataAnnotations;
using System.Globalization;
using System.Configuration;

namespace Max.Web.Presentation.Infrastructure.Razor
{
    public static class RazorExtensions
    {
        public static SystemUser CurrentUser(this HtmlHelper helper)
        {
            return AuthorizeHelper.GetCurrentUser();
        }

       

        public static string FirstError(this ModelStateDictionary state)
        {
            return state.Values.First(v => v.Errors.Count > 0).Errors[0].ErrorMessage;
        }

        #region 分页控件

        public static MvcGrid<TModel, TParam> PageView<TModel, TParam>(
            this HtmlHelper<Query<TModel, TParam>> helper,
            string actionName,
            string controllerName,
            string formId,
            string containerId,
            string partialView,
            Query<TModel, TParam> model
            ) where TParam : new()
        {
            helper.BeginForm(actionName, controllerName, FormMethod.Post, new { id = formId, @class = "form" });
            model.__formId = formId;
            model.__containerId = containerId;
            model.__partialView = partialView;
            return new MvcGrid<TModel, TParam>(helper.ViewContext, helper, model);
        }

        public static MvcGridPagerOfT<TModel, TParam> GridPager<TModel, TParam>(this HtmlHelper<Query<TModel, TParam>> helper, Query<TModel, TParam> model, int halfBarSize = 5) where TParam : new()
        {
            return new MvcGridPagerOfT<TModel, TParam>(model, halfBarSize);
        }

        #endregion

        #region SelecrFor

        public static MvcHtmlString SelectFor<TEnum, TModel, TProperty>(this HtmlHelper<TModel> htmlHelper, Expression<Func<TModel, TProperty>> expression)
        {
            return SelectFor(htmlHelper, expression, typeof(TEnum));
        }

        public static MvcHtmlString SelectFor<TModel>(this HtmlHelper<TModel> htmlHelper, string property, string propertyVal, Type enumType, string nullValue = null, string classValue = "weui_select", string dir = "rtl")
        {
            var keyValueList = dicEnum.GetOrAdd(enumType, GetKeyValueList);

            var builder = new StringBuilder();
            builder.AppendFormat("<select  id='{0}'  name='{0}' class='{1}' dir='{2}' >", property, classValue, dir).AppendLine();
            if (!nullValue.IsNullOrEmpty())
                builder.AppendFormat("<option value=\"\">{0}</option>", nullValue).AppendLine();

            foreach (var pair in keyValueList)
            {
                builder.AppendFormat("<option {0} value={1}>{2}</option>", propertyVal == pair.Value ? "selected=\"selected\"" : "", pair.Value, pair.Key);
            }
            builder.AppendLine("</select>");

            return new MvcHtmlString(builder.ToString());
        }

        public static MvcHtmlString SelectFor<TModel, TProperty>(this HtmlHelper<TModel> htmlHelper, Expression<Func<TModel, TProperty>> expression, Type enumType, string nullValue = null, string classValue = "weui_select")
        {
            var keyValueList = dicEnum.GetOrAdd(enumType, GetKeyValueList);
            var modelProperty = GetExpressionValue(htmlHelper, expression);

            var builder = new StringBuilder();
            builder.AppendFormat("<select  id='{0}'  name='{0}' class='{1}' dir=\"rtl\" >", modelProperty.Key, classValue).AppendLine();
            if (!nullValue.IsNullOrEmpty())
                builder.AppendFormat("<option value=\"\">{0}</option>", nullValue).AppendLine();

            foreach (var pair in keyValueList)
            {
                builder.AppendFormat("<option {0} value={1}>{2}</option>", modelProperty.Value == pair.Value ? "selected=\"selected\"" : "", pair.Value, pair.Key);
            }
            builder.AppendLine("</select>");

            return new MvcHtmlString(builder.ToString());
        }

        public static MvcHtmlString SelectFor<TModel, TProperty>(this HtmlHelper<TModel> htmlHelper, Expression<Func<TModel, TProperty>> expression, Type enumType, string nullValue, string classValue, string dir)
        {
            var keyValueList = dicEnum.GetOrAdd(enumType, GetKeyValueList);
            var modelProperty = GetExpressionValue(htmlHelper, expression);

            var builder = new StringBuilder();
            builder.AppendFormat("<select  id='{0}'  name='{0}' class='{1}' dir=\"{2}\" >", modelProperty.Key, classValue, dir).AppendLine();
            if (!nullValue.IsNullOrEmpty())
                builder.AppendFormat("<option value=\"\">{0}</option>", nullValue).AppendLine();

            foreach (var pair in keyValueList)
            {
                builder.AppendFormat("<option {0} value={1}>{2}</option>", modelProperty.Value == pair.Value ? "selected=\"selected\"" : "", pair.Value, pair.Key);
            }
            builder.AppendLine("</select>");

            return new MvcHtmlString(builder.ToString());
        }

        #endregion

        #region RadioListFor

        /// <summary>
        /// 单选按钮组
        /// </summary>
        /// <typeparam name="TModel"></typeparam>
        /// <typeparam name="TProperty"></typeparam>
        /// <param name="htmlHelper"></param>
        /// <param name="expression"></param>
        /// <param name="enumType">枚举类型</param>
        /// <param name="inline">是否显示在同一行</param>
        /// <param name="nullValue">值为空(不在枚举中)的选项名称</param>
        /// <returns></returns>
        public static MvcHtmlString RadioListFor<TModel, TProperty>(this HtmlHelper<TModel> htmlHelper, Expression<Func<TModel, TProperty>> expression, Type enumType, bool inline = true, string nullValue = null)
        {
            var keyValueList = dicEnum.GetOrAdd(enumType, GetKeyValueList);
            var modelProperty = GetExpressionValue(htmlHelper, expression);

            var builder = new StringBuilder();
            builder.AppendLine("<div class=\"form-group\"><div class=\"radio-list\">");
            if (!nullValue.IsNullOrEmpty())
            {
                if (inline)
                    builder.AppendLine("<label class=\"radio-inline\">");
                else
                    builder.AppendLine("<label class=\"radio\">");

                builder.AppendFormat("<input type=\"radio\" {0} name=\"{1}\" value=\"\"> {2}", modelProperty.Value.IsNullOrEmpty() ? "checked" : "", modelProperty.Key, nullValue);
                builder.AppendLine("</label>");
            }

            foreach (var pair in keyValueList)
            {
                if (inline)
                    builder.AppendLine("<label class=\"radio-inline\">");
                else
                    builder.AppendLine("<label class=\"radio\">");

                builder.AppendFormat("<input type=\"radio\" {0} name=\"{1}\" value=\"{2}\"> {3}", modelProperty.Value == pair.Value ? "checked" : "", modelProperty.Key, pair.Value, pair.Key);
                builder.AppendLine("</label>");
            }

            builder.AppendLine("</div></div>");
            return new MvcHtmlString(builder.ToString());
        }

        #endregion


        #region 日期控件
        /// <param name="formatType">0短日期 1长日期</param>
        public static MvcHtmlString DayPickerFor<TModel, TProperty>(this HtmlHelper<TModel> helper, Expression<Func<TModel, TProperty>> expression, string placeholder = "", int formatType = 0, DateTime? startDate = null, DateTime? endDate = null)
        {
            var kv = GetExpressionValue<TModel, TProperty>(helper, expression);
            var builder = new StringBuilder();
            var value = "";
            if (!kv.Value.IsNullOrEmpty())
            {
                var date = new DateTime();
                if (DateTime.TryParse(kv.Value, out date))
                {
                    if (formatType == 0)
                        value = date.ToString("yyyy-MM-dd");
                    else
                        value = date.ToString("yyyy-MM-dd HH:mm:ss");
                }
                else
                    value = kv.Value;
            }
            var id = Guid.NewGuid().ToString();
            builder.AppendFormat("<div id='{3}' class='input-group date form_datetime' data-format='{0}' data-start='{1}'  data-end='{2}'>", formatType, startDate.HasValue ? startDate.Value.ToString("yyyy-MM-dd HH:mm") : "", endDate.HasValue ? endDate.Value.ToString("yyyy-MM-dd HH:mm") : "", id);
            builder.AppendFormat("<input name='{0}' id='{0}' type='text' size='16' readonly class='form-control' placeholder='{1}' value='{2}'>", kv.Key, placeholder, value).AppendLine();
            builder.AppendLine("<span class='input-group-btn'>");
            builder.AppendLine("<button class='btn default date-reset date-set' type='button'><i class='fa fa-times'></i></button>");
            builder.AppendLine("</span>");
            builder.AppendLine("</div>");
            builder.AppendLine(@"<script>$(document).ready(function () {App.RegisterDate($('#" + id + "'));})</script>");
            return new MvcHtmlString(builder.ToString());
        }

        /// <summary>
        /// 日期控件
        /// </summary>
        /// <typeparam name="TModel"></typeparam>
        /// <typeparam name="TProperty"></typeparam>
        /// <param name="helper"></param>
        /// <param name="expression"></param>
        /// <param name="placeholder"></param>
        /// <param name="formatType">0 - YYYY-MM-DD, 1 - YYYY-MM-DD HH:mm, 2 - YYYY-MM-DD HH:mm:ss</param>
        /// <param name="startDate"></param>
        /// <param name="endDate"></param>
        /// <returns></returns>
        public static MvcHtmlString DayTimePickerFor<TModel, TProperty>(this HtmlHelper<TModel> helper,
            Expression<Func<TModel, TProperty>> expression, string placeholder = "", int formatType = 0,
            DateTime? startDate = null, DateTime? endDate = null)
        {
            string value = "";
            string format = "YYYY-MM-DD HH:mm:ss";
            string csFormat = "yyyy-MM-dd HH:mm:ss";
            int inputWidth = 201;
            KeyValuePair<string, string> kv = GetExpressionValue<TModel, TProperty>(helper, expression);


            switch (formatType)
            {
                case 0:
                    format = "YYYY-MM-DD";
                    csFormat = "yyyy-MM-dd";
                    break;
                case 1:
                    format = "YYYY-MM-DD HH:mm";
                    csFormat = "yyyy-MM-dd HH:mm";
                    break;
                case 2:
                    format = "YYYY-MM-DD HH:mm:ss";
                    csFormat = "yyyy-MM-dd HH:mm:ss";
                    break;
            }
            if (!kv.Value.IsNullOrEmpty())
            {
                DateTime date;
                value = DateTime.TryParse(kv.Value, out date) ? date.ToString(csFormat) : kv.Value;
            }

            string id = Guid.NewGuid().ToString();
            StringBuilder options = new StringBuilder();
            StringBuilder builder = new StringBuilder();

            if (startDate.HasValue)
            {
                options.AppendFormat("minDate: '{0}',", startDate.Value.ToString(format));
            }
            if (endDate.HasValue)
            {
                options.AppendFormat("maxDate: '{0}'", endDate.Value.ToString(format));
            }

            options.AppendFormat("format: '{0}',", format);
            options.Append("showTodayButton: true, showClear: true");

            builder.AppendLine(string.Format("<div class='input-group' style='width: {0}px;' >", inputWidth));
            builder.AppendLine(string.Format(
                "<input type='text' class='form-control' name='{0}' value='{1}' placeholder='{2}' id='{3}' />",
                kv.Key, value, placeholder, id));
            builder.AppendLine("<span class='input-group-addon'>");
            builder.AppendLine("<span class='glyphicon glyphicon-calendar'></span>");
            builder.AppendLine("</span>");
            builder.AppendLine("</div>");
            builder.AppendFormat("<script type=\"text/javascript\">$(function () {{$('#{0}').datetimepicker({{ {1} }});}});</script>", id, options.ToString());

            return new MvcHtmlString(builder.ToString());
        }



        /// <summary>
        /// 时间控件,支持“hh:mm:ss”和“hh:mm”
        /// <Author>MAX</Author>
        /// </summary>
        /// <typeparam name="TModel">输入参数模型</typeparam>
        /// <typeparam name="TProperty">FC返回类型</typeparam>
        /// <param name="helper">被扩展类型</param>
        /// <param name="expression">表达式</param>
        /// <param name="formatType">1:hh:mm:ss,0:hh:mm</param>
        /// <returns>控件的MvcHtmlString对象</returns>
        public static MvcHtmlString TimePickerFor<TModel, TProperty>(this HtmlHelper<TModel> helper, Expression<Func<TModel, TProperty>> expression, int formatType = 1)
        {
            var kv = GetExpressionValue<TModel, TProperty>(helper, expression);
            var htmlStr = new StringBuilder(200);
            string value = "";
            if (!kv.Value.IsNullOrEmpty())
            {
                DateTime dtVal;
                if (DateTime.TryParse(kv.Value, out dtVal))
                    value = dtVal.ToString();
                else
                    value = kv.Value;
            }
            if (formatType == 1)
            {
                htmlStr.AppendLine("<div class='input-icon'>");
                htmlStr.AppendLine("<div class='input-icon'>");
                htmlStr.AppendLine("<i class='fa fa-clock-o'></i>");
                htmlStr.AppendFormat("<input name='{0}' id='{0}' type='text' class='form-control timepicker timepicker-default' value='{1}'>", kv.Key, value.TimeFormat()).AppendLine();
                htmlStr.AppendLine("</div>");
            }
            else
            {
                htmlStr.AppendLine("<div class='input-group'>");
                htmlStr.AppendFormat("<input name='{0}' id='{0}' type='text' class='form-control timepicker timepicker-no-seconds' value='{1}'>", kv.Key, value.TimeFormat()).AppendLine();
                htmlStr.AppendLine("<span class='input-group-btn'>");
                htmlStr.AppendLine("<button class='btn default' type='button'><i class='fa fa-clock-o'></i></button>");
                htmlStr.AppendLine("</span>");
                htmlStr.AppendLine("</div>");
            }
            htmlStr.AppendLine("<script type='text/javascript'>$(document).ready(function () { ComponentsPickers.init(); });</script>");
            return new MvcHtmlString(htmlStr.ToString());
        }


        /// <summary>
        /// 根据输入的时间格式进行相互转化，如：4:56:30 PM <=> 16:56:30
        /// <Author>MAX</Author>
        /// </summary>
        /// <param name="oriTime">原始时间</param>
        /// <returns>格式化后的时间</returns>
        public static string TimeFormat(this string oriTime)
        {
            if (oriTime.IsNullOrWhiteSpace()) return string.Empty;
            oriTime = oriTime.Trim();
            string result;
            if (Regex.IsMatch(oriTime, @"^([1-9]|1[0-2]):[0-5]\d{1}:[0-5]\d{1}\s*[AaPp][Mm]$"))
            {
                DateTimeFormatInfo dtfi = new CultureInfo("en-US", false).DateTimeFormat;
                dtfi.ShortTimePattern = "t";
                DateTime dt = DateTime.Parse(oriTime, dtfi);
                result = dt.ToString("yyyy-MM-dd HH:mm:ss").Remove(0, 10).Trim();
            }
            else
            {
                var time = Convert.ToDateTime(oriTime);
                var forTime = string.Format("{0:yyyy-MM-dd hh:mm:ss tt }", time).Replace("上午", "AM").Replace("下午", "PM");
                result = forTime.Remove(0, 10).Trim();
            }
            return result;
        }

        #endregion

        #region 标签输入
        public static MvcHtmlString TagsInputFor<TModel, TProperty>(this HtmlHelper<TModel> htmlHelper, Expression<Func<TModel, TProperty>> expression, object htmlAttributes = null, int? count = null, int? length = null, string defaultText = "添加标签")
        {
            var modelProperty = GetExpressionValue(htmlHelper, expression);
            var builder = new StringBuilder();
            builder.AppendFormat("<input type=\"text\" id=\"{0}\" name=\"{0}\" class=\"tags form-control\"  value=\"{1}\" ", modelProperty.Key, modelProperty.Value);
            if (!htmlAttributes.IsNull())
            {
                var htmlAttrArray = htmlAttributes.GetType().GetProperties();
                foreach (var item in htmlAttrArray)
                {
                    var val = item.GetValue(htmlAttributes, null);
                    builder.AppendFormat(" {0}=\"{1}\" ", item.Name, val);
                }
            }
            builder.Append(" />");
            builder.AppendLine("<script>");
            builder.AppendLine(@"$(document).ready(function () {");
            builder.AppendLine("var handleTagsInput = function (count,length) {");
            builder.AppendLine(" if (!jQuery().tagsInput) {");
            builder.AppendLine("return;");
            builder.AppendLine(" }");
            builder.AppendLine(" $('.tags').tagsInput({");
            builder.AppendLine("width: 'auto',");
            builder.AppendLine("defaultText: '" + defaultText + "',");
            builder.AppendLine(" 'onAddTag': function (data) {");
            builder.AppendLine("console.log(data);");
            builder.AppendLine(" var tagslist = $('#" + modelProperty.Key + "').val();");

            if (count.HasValue && length.HasValue)
            {
                builder.AppendLine("var sl = tagslist.split(',');");
                builder.AppendLine("if (sl.length > " + count + ") {");
                builder.AppendLine("App.Alert('最多只能输入" + count + "个标签！');");
                builder.AppendLine("$('#" + modelProperty.Key + "').removeTag(data);");
                builder.AppendLine("}");
                builder.AppendLine("for (var i = 0; i < sl.length; i++) {");
                builder.AppendLine("if (sl[i].length > " + length + ") {");
                builder.AppendLine("App.Alert('每个标签最多" + length + "个字符！');");
                builder.AppendLine("$('#" + modelProperty.Key + "').removeTag(data);");
                builder.AppendLine(" }");
                builder.AppendLine(" }");
            }
            builder.AppendLine(" },");
            builder.AppendLine("});");
            builder.AppendLine(" }");
            if (count.HasValue && length.HasValue)
            {
                builder.AppendLine(" handleTagsInput(" + count + "," + length + ");");
            }
            else
            {
                builder.AppendLine(" handleTagsInput();");
            }

            builder.AppendLine(@"});");
            builder.AppendLine("</script>");
            return new MvcHtmlString(builder.ToString());
        }
        #endregion

        #region 文件导出Button

        public static MvcHtmlString ExportFileFor(this HtmlHelper helper, string formId, string controller, string action, int? permcode = null)
        {
            var builder = new StringBuilder();
            builder.AppendFormat("<a permid='{3}' onclick=\"App.exportFile('{0}', '{1}', '{2}');\" class=\"btn green\"><i class=\"glyphicon glyphicon-cloud-download\"></i> 导出</a>", formId, controller, action, permcode);
            return new MvcHtmlString(builder.ToString());
        }
        #endregion

        #region 辅助方法

        /// <summary>
        /// 返回属性的名称和值
        /// </summary>
        /// <typeparam name="TModel"></typeparam>
        /// <typeparam name="TProperty"></typeparam>
        /// <param name="expression"></param>
        /// <returns></returns>
        private static KeyValuePair<string, string> GetExpressionValue<TModel, TProperty>(HtmlHelper<TModel> htmlHelper, Expression<Func<TModel, TProperty>> expression)
        {
            var key = ExpressionHelper.GetExpressionText(expression);
            TProperty value = htmlHelper.ViewData.Model == null ? default(TProperty) : MemberAccessor.Process(expression, htmlHelper.ViewData.Model);
            return new KeyValuePair<string, string>(key, Convert.ToString(value));
        }

        private static ConcurrentDictionary<Type, List<KeyValuePair<string, string>>> dicEnum = new ConcurrentDictionary<Type, List<KeyValuePair<string, string>>>();

        private static List<KeyValuePair<string, string>> GetKeyValueList(Type enumType)
        {
            var kvList = new List<KeyValuePair<string, string>>();
            var fields = enumType.GetFields(BindingFlags.Static | BindingFlags.Public);
            var underlyingType = Enum.GetUnderlyingType(enumType);

            foreach (var field in fields)
            {
                var v = field.GetValue(null);
                var value = Convert.ChangeType(v, underlyingType).ToString();
                var display = field.GetCustomAttributes(typeof(DisplayAttribute), true)
                        .Cast<DisplayAttribute>()
                        .FirstOrDefault();
                kvList.Add(new KeyValuePair<string, string>(display != null ? display.Name : field.Name, value));
            }
            return kvList;
        }

        #endregion

        #region 文件选择

        /// <summary>
        /// 文件选择
        /// </summary>
        /// <param name="helper"></param>
        /// <param name="name">文件选择标签的name属性</param>
        /// <param name="text">显示的文本</param>
        /// <returns></returns>
        public static MvcHtmlString FileSelect(this HtmlHelper helper, string name, string text)
        {
            var builder = new StringBuilder();
            builder.Append("<div class=\"fileinput fileinput-new\" data-provides=\"fileinput\">");

            builder.Append("<div class=\"input-group input-large\">");
            builder.Append("<div class=\"form-control uneditable-input input-fixed input-medium\" data-trigger=\"fileinput\">");
            builder.Append("<i class=\"fa fa-file fileinput-exists\"></i>&nbsp;");
            builder.Append("<span class=\"fileinput-filename\"></span>");
            builder.Append("</div>");
            builder.Append("<span class=\"input-group-addon btn default btn-file\">");
            builder.Append("<span class=\"fileinput-new\">");
            builder.Append(text);
            builder.Append("</span>");
            builder.Append("<span class=\"fileinput-exists\">");
            builder.Append("重选");
            builder.Append("</span>");
            builder.AppendFormat("<input type=\"file\" name=\"{0}\">", name);
            builder.Append("</span>");
            builder.Append("<a href=\"javascript:;\" class=\"input-group-addon btn red fileinput-exists\" data-dismiss=\"fileinput\">");
            builder.Append("移除");
            builder.Append("</a>");
            builder.Append("</div>");
            builder.Append("</div>");
            return new MvcHtmlString(builder.ToString());
        }
        #endregion

        #region 颜色选择

        /// <summary>
        /// 颜色选择器
        /// </summary>
        /// <typeparam name="TModel"></typeparam>
        /// <typeparam name="TProperty"></typeparam>
        /// <param name="htmlHelper"></param>
        /// <param name="expression"></param>
        /// <param name="htmlAttributes">class="form-control miniColor"</param>
        /// <param name="colorStyle">默认样式</param>
        /// <returns></returns>
        public static MvcHtmlString ColorSelectFor<TModel, TProperty>(this HtmlHelper<TModel> htmlHelper, Expression<Func<TModel, TProperty>> expression, object htmlAttributes = null, string colorStyle = "hue")
        {
            var modelProperty = GetExpressionValue(htmlHelper, expression);
            var builder = new StringBuilder();
            builder.AppendFormat("<input type=\"text\" id=\"{0}\" name=\"{0}\" class=\"miniColor form-control\" data-control=\"{1}\" value=\"{2}\" ", modelProperty.Key, colorStyle.ToLower(), modelProperty.Value);
            if (!htmlAttributes.IsNull())
            {
                var htmlAttrArray = htmlAttributes.GetType().GetProperties();
                foreach (var item in htmlAttrArray)
                {
                    var val = item.GetValue(htmlAttributes, null);
                    builder.AppendFormat(" {0}=\"{1}\" ", item.Name, val);
                }
            }
            builder.Append(" />");

            //builder.AppendLine("<script type='text/javascript'>");

            //builder.AppendLine("ComponentsFormTools.init();");
            //builder.AppendLine("</script>");
            return new MvcHtmlString(builder.ToString());
        }
        #endregion

        #region 上传控件
        /// <summary>
        /// 上传控件
        /// </summary>
        /// <typeparam name="TModel"></typeparam>
        /// <typeparam name="TProperty"></typeparam>
        /// <param name="helper"></param>
        /// <param name="expression"></param>
        /// <param name="placeholder"></param>
        /// <param name="formatType"></param>
        /// <param name="startDate"></param>
        /// <param name="endDate"></param>
        /// <returns></returns>
        public static MvcHtmlString FileUploadFor<TModel, TProperty>(this HtmlHelper<TModel> helper, Expression<Func<TModel, TProperty>> expression, string btnID, string btnText, string imgID, int fileSizeLimit, string acceptTitle = "Images", string extensions = "gif,jpg,jpeg,bmp,png", string mimeTypes = "image/*", bool InnerOrOut = true)
        {
            var kv = GetExpressionValue<TModel, TProperty>(helper, expression);
            string FileUploadUrl = ConfigurationManager.AppSettings["FileUploadUrl"].ToString();
            var builder = new StringBuilder();

            var id = Guid.NewGuid().ToString("N");



            builder.AppendLine("<div class=\"upload_box pull-left\">");
            builder.AppendLine("<img id=\"" + imgID + "\" src=\"" + kv.Value + "\" class=\"am-img-responsive am-margin-bottom-sm  pull-left margin-bottom-5\" style=\"max-width:100px;\" alt=\"\" />");
            builder.AppendLine("<div class=\"clearfix\"></div>");
            builder.AppendLine("<span class=\"upload_area\">");
            builder.AppendLine("<a href=\"javascript:;\" id=\"" + btnID + "\" class=\"btn btn_upload js_select_file pull-left margin-left-5\" style=\"height:32px;padding:0;\">" + btnText + "</a>");

            builder.AppendLine("<a href=\"javascript:;\" id=\"btnCancel" + kv.Key + "\"   class=\"btn btn-danger  pull-left\" style=\"display: inline;height: 40px;\"><i class=\"fa fa-trash-o\"></i> 清除</a>");
            builder.AppendLine("<span  class=\"upload_file_box\" style=\"display: none;\"></span>");
            builder.AppendLine("</span>");
            builder.AppendLine("<input type=\"hidden\" name=\"" + kv.Key + "\" id=\"" + kv.Key + "\" value=\"" + kv.Value + "\">");
            builder.AppendLine("</div>");

            builder.AppendLine("<script>");
            builder.AppendLine(@"$(document).ready(function () {");
            builder.AppendLine("var uploader" + kv.Key + " = WebUploader.create({");
            builder.AppendLine("auto: true,");
            builder.AppendLine("duplicate: true,");
            builder.AppendFormat("swf: '{0}',", "~/content/webuploader/Uploader.swf").AppendLine();
            builder.AppendLine("server: '/Upload/FileUpload',");
            builder.AppendLine("pick: {");
            builder.AppendLine("id: '#" + btnID + "',");
            builder.AppendLine("multiple: false");
            builder.AppendLine("},");
            builder.AppendLine("fileSizeLimit: " + fileSizeLimit + ",");
            builder.AppendLine("accept: {");
            builder.AppendLine("title: '" + acceptTitle + "',");
            builder.AppendLine("accept: {");
            builder.AppendLine("extensions: '" + extensions + "',");
            builder.AppendLine(" mimeTypes: '" + mimeTypes + "'");
            builder.AppendLine("}");
            builder.AppendLine("}");
            builder.AppendLine("});");



            builder.AppendLine("uploader" + kv.Key + ".on('uploadSuccess', function (file, result) {");
            //builder.AppendLine("console.log(data);");
            //builder.AppendLine("var result = JSON.parse(data);");

            builder.AppendLine("if (parseInt(result.Code)==parseInt(\"10001\")) {");
            builder.AppendLine("$('#" + kv.Key + "').val(result.Result.Url);");
            builder.AppendLine("$('#" + imgID + "').attr('src', result.Result.Url);");
            builder.AppendLine("}else{");
            builder.AppendLine("App.Alert(result.Message)");
            builder.AppendLine("}");
            builder.AppendLine("uploader" + kv.Key + ".reset();");
            builder.AppendLine("});");

            // 文件上传失败，显示上传出错。

            builder.AppendLine("uploader" + kv.Key + ".on('uploadError', function (file) {");
            builder.AppendLine("var $li = $('#' + file.id),");
            builder.AppendLine("$error = $li.find('div.error');");
            builder.AppendLine("if (!$error.length) {");
            builder.AppendLine("$error = $('<div class=\"error\"></div>').appendTo($li);");
            builder.AppendLine("} ");
            builder.AppendLine("$error.text('上传失败');");
            builder.AppendLine("});");
            builder.AppendLine("uploader" + kv.Key + ".on('error', function (e) {");
            builder.AppendLine(@"switch (e) {");
            builder.AppendLine(@"case 'Q_EXCEED_NUM_LIMIT': App.Alert(文件数量超出1个); break;");
            builder.AppendLine(@"case 'Q_EXCEED_SIZE_LIMIT':App.Alert('超过上传的文件大小限制！'); break;");
            builder.AppendLine(@"case 'Q_TYPE_DENIED':App.Alert('超出上传的文件类型限制！');break;");
            builder.AppendLine(@"default:App.Alert('上传出错，请重试！');break;");
            builder.AppendLine(@"}");
            builder.AppendLine(@"});");
            //取消按钮
            builder.AppendLine(@"$('#btnCancel" + kv.Key + "').on(\"click\", function () {");
            builder.AppendLine(@"$('#" + imgID + "').attr(\"src\", \"\");");
            builder.AppendLine(@"$('#" + kv.Key + "').val(\"\");");
            builder.AppendLine(@"});");



            builder.AppendLine(@"});");
            builder.AppendLine("</script>");
            return new MvcHtmlString(builder.ToString());
        }

        #endregion

        #region 复选框组

        /// <summary>
        /// 复选框组
        /// </summary>
        /// <typeparam name="TModel"></typeparam>
        /// <typeparam name="TProperty"></typeparam>
        /// <param name="htmlHelper"></param>
        /// <param name="expression"></param>
        /// <param name="enumType">枚举类型</param>
        /// <param name="inline">是否显示在同一行</param>
        /// <param name="nullValue">值为空(不在枚举中)的选项名称</param>
        /// <returns></returns>
        public static MvcHtmlString CheckBoxListFor<TModel, TProperty>(this HtmlHelper<TModel> htmlHelper, Expression<Func<TModel, TProperty>> expression, Type enumType, bool inline = true, string nullValue = null)
        {
            var keyValueList = dicEnum.GetOrAdd(enumType, GetKeyValueList);
            var modelProperty = GetExpressionValue(htmlHelper, expression);

            var builder = new StringBuilder();
            builder.AppendLine("<div class=\"checkbox-list\">");
            if (!nullValue.IsNullOrEmpty())
            {
                if (inline)
                    builder.AppendLine("<label class=\"checkbox-inline\">");
                else
                    builder.AppendLine("<label class=\"\">");
                builder.AppendLine("<div class=\"checker\">");
                builder.AppendLine("<span>");
                builder.AppendFormat("<input type=\"checkbox\" {0} class='form-control' id=\"{1}\" name=\"{2}\" value=\"\">", modelProperty.Value.IsNullOrEmpty() ? "checked" : "", modelProperty.Key, modelProperty.Key);
                builder.AppendLine("</span>");
                builder.AppendLine("</div>");
                builder.AppendFormat("{0}", nullValue);
                builder.AppendLine("</label>");
            }
            builder.AppendLine(" <input type=\"hidden\" name=\"" + modelProperty.Key + "\" id=\"" + modelProperty.Key + "\" value=\"" + modelProperty.Value + "\" />");
            foreach (var pair in keyValueList)
            {
                if (inline)
                    builder.AppendLine("<label class=\"checkbox-inline\">");
                else
                    builder.AppendLine("<label class=\"\">");
                builder.AppendFormat("<input type=\"checkbox\"  {0} name=\"{1}\" value=\"{2}\" class='form-control' id=\"{3}\"  targetfor=\"{4}\">", modelProperty.Value.Contains("," + pair.Value + ",") ? "checked" : "", modelProperty.Key + pair.Value, pair.Value, modelProperty.Key + pair.Value, modelProperty.Key);

                builder.AppendFormat("{0}", pair.Key);
                builder.AppendLine("</label>");
                builder.AppendLine("<script>");
                builder.AppendLine(@"$('#" + modelProperty.Key + pair.Value + "').on(\"click\", function () {");
                builder.AppendLine(@"var SaleTagsStr" + pair.Value + " = \",\";");
                builder.AppendLine("$(\"[targetfor='" + modelProperty.Key + "']:checked\").each(function () {");
                builder.AppendLine("SaleTagsStr" + pair.Value + " += $(this).val()+\",\";");
                builder.AppendLine("});");
                builder.AppendLine("$(\"#" + modelProperty.Key + "\").val(SaleTagsStr" + pair.Value + ");");
                builder.AppendLine(" });");

                builder.AppendLine("</script>");





            }

            builder.AppendLine("</div>");

            return new MvcHtmlString(builder.ToString());
        }

        #endregion

        //#region 标签强类型控件

        ///// <summary>
        ///// 标签控件
        ///// </summary>
        ///// <typeparam name="TModel"></typeparam>
        ///// <typeparam name="TProperty"></typeparam>
        ///// <param name="htmlHelper"></param>
        ///// <param name="expression"></param>
        ///// <param name="attr">自定义属性如： placeholder = '请输入'</param>
        ///// <param name="count">限制多少个</param>
        ///// <param name="length">每个不超过多少字符</param>
        ///// <returns></returns>
        //public static MvcHtmlString TagsInputFor<TModel, TProperty>(this HtmlHelper<TModel> htmlHelper, Expression<Func<TModel, TProperty>> expression, string attr, int? count, int? length)
        //{
        //    var builder = new StringBuilder();
        //    var kv = GetExpressionValue<TModel, TProperty>(htmlHelper, expression);
        //    builder.AppendFormat("<input type=\"text\" id=\"{0}\" name=\"{1}\" class=\"form-control tags\"  value=\"{2}\" {3}>", kv.Key, kv.Key, kv.Value, attr);

        //    //builder.AppendLine("<script>");
        //    //builder.AppendLine(@"$(document).ready(function () {");
        //    //builder.AppendLine("var handleTagsInput = function (count,length) {");
        //    //builder.AppendLine(" if (!jQuery().tagsInput) {");
        //    //builder.AppendLine("return;");
        //    //builder.AppendLine(" }");
        //    //builder.AppendLine(" $('.tags').tagsInput({");
        //    //builder.AppendLine("width: 'auto',");
        //    //builder.AppendLine("defaultText: '添加标签',");
        //    //builder.AppendLine(" 'onAddTag': function (data) {");
        //    //builder.AppendLine("console.log(data);");
        //    //builder.AppendLine(" var tagslist = $('#" + kv.Key + "').val();");

        //    //if (count.HasValue && length.HasValue)
        //    //{
        //    //    builder.AppendLine("var sl = tagslist.split(',');");
        //    //    builder.AppendLine("if (sl.length > " + count + ") {");
        //    //    builder.AppendLine("App.Alert('最多只能输入" + count + "个标签！');");
        //    //    builder.AppendLine("$('#" + kv.Key + "').removeTag(data);");
        //    //    builder.AppendLine("}");
        //    //    builder.AppendLine("for (var i = 0; i < sl.length; i++) {");
        //    //    builder.AppendLine("if (sl[i].length > " + length + ") {");
        //    //    builder.AppendLine("App.Alert('每个标签最多" + length + "个字符！');");
        //    //    builder.AppendLine("$('#" + kv.Key + "').removeTag(data);");
        //    //    builder.AppendLine(" }");
        //    //    builder.AppendLine(" }");
        //    //}  
        //    //builder.AppendLine(" },");
        //    //builder.AppendLine("});");
        //    //builder.AppendLine(" }");
        //    //if (count.HasValue && length.HasValue)
        //    //{
        //    //    builder.AppendLine(" handleTagsInput("+count+","+length+");"); 
        //    //}
        //    //else
        //    //{
        //    //    builder.AppendLine(" handleTagsInput();"); 
        //    //}

        //    //builder.AppendLine(@"});");
        //    //builder.AppendLine("</script>");
        //    //标签输入,count限制多少个，length每个最多多少个字符串  
        //    return new MvcHtmlString(builder.ToString());
        //}

        //#endregion


        #region WMEditor富文本编辑器
        public static MvcHtmlString UMEditorFor<TModel, TProperty>(this HtmlHelper<TModel> htmlHelper, Expression<Func<TModel, TProperty>> expression, object htmlAttributes = null)
        {
            var builder = new StringBuilder();
            var kv = GetExpressionValue(htmlHelper, expression);
            builder.AppendFormat("<script type=\"text/plain\" id=\"{0}\" name=\"{0}\"", kv.Key);
            bool isHasStyle = false;
            if (!htmlAttributes.IsNull())
            {
                var htmlAttrArray = htmlAttributes.GetType().GetProperties();

                foreach (var item in htmlAttrArray)
                {
                    if (item.Name.ToLower() == "style")
                    {
                        isHasStyle = true;
                    }
                    var val = item.GetValue(htmlAttributes, null);
                    builder.AppendFormat(" {0}=\"{1}\" ", item.Name, val);
                }
            }
            if (!isHasStyle)
            {
                builder.Append("style=\"width:750px;height:240px;\"");
            }

            builder.Append("> \r\n");
            builder.AppendLine(kv.Value);
            builder.AppendLine("</script>");
            builder.AppendLine("<script type=\"text/javascript\">");
            builder.AppendLine("$(function () {");
            builder.AppendFormat("var um = UM.getEditor('{0}');\r\n", kv.Key);
            builder.AppendLine("});");
            builder.AppendLine("</script>");

            return new MvcHtmlString(builder.ToString());
        }

        #endregion


    }
}