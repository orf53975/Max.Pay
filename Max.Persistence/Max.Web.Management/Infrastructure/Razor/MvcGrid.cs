﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Web;
using System.Web.Mvc;
using System.Web.Mvc.Html;
using System.Web.UI;

namespace Max.Web.Management.Infrastructure.Razor
{
    public class MvcGrid<TModel, TParam> :MvcForm where TParam: new()
    {
        private bool _paged;
        private HtmlHelper<Query<TModel, TParam>> helper;
        private Query<TModel, TParam> model;

        public MvcGrid(ViewContext viewContext, HtmlHelper<Query<TModel, TParam>> helper, Query<TModel, TParam> model) : base(viewContext) {
            this.helper = helper;
            this.model = model;
            WriteParameters();
        }

        private void Write(string html)
        {
            helper.ViewContext.Writer.Write(html);
        }

        private void WriteFormat(string format, params object[] args)
        {
            helper.ViewContext.Writer.WriteLine(format, args);
        }

        private void WriteParameters()
        {
            WriteFormat("<input type=hidden name='__partialView' value='{0}' />", model.__partialView);
            WriteFormat("<input type=hidden name='__pageIndex' value='{0}' />", model.__pageIndex);
            WriteFormat("<input type=hidden name='__pageSize' value='{0}' />", model.__pageSize);
            WriteFormat("<input type=hidden name='__totalPage' value='{0}' />", model.__totalPage);
            WriteFormat("<input type=hidden name='__formId' value='{0}' />", model.__formId);
            WriteFormat("<input type=hidden name='__containerId' value='{0}' />", model.__containerId);
        }

        protected override void Dispose(bool disposing)
        {
            base.Dispose(disposing);
            if (!_paged)
            {
                _paged = true;
                RenderView();
            }
        }

        private void RenderView()
        {
            WriteFormat("<div id=\"{0}\" class=\"clearfix\">", model.__containerId);
            helper.RenderPartial(model.__partialView, model);
            Write("</div>");
            Write("<script type='text/javascript'>$(function(){$.pageRegister('" + model.__formId + "', '" + model.__containerId + "');});</script>");
        }
    }

    public class MvcGridPagerOfT<TModel, TParam> : MvcGridPager where TParam : new()
    {
        public MvcGridPagerOfT(Query<TModel, TParam> query, int halfBarSize)
            : base(query.__pageIndex, query.__pageSize, query.__totalRecord, query.__formId, query.__containerId, halfBarSize) { }
    }

    public class MvcGridPager : IHtmlString
    {
        private StringBuilder _builder = new StringBuilder();

        private int _pageIndex;
        private int _pageSize;
        private int _totalRecord;
        private int _totalPage;
        private int _halfBarSize;
        private string _formId;
        private string _containerId;
        private int[] _sizeArray = { 10, 20, 30, 40, 50 };

        public MvcGridPager(int pageIndex, int pageSize, int totalRecord, string formId, string containerId, int halfBarSize)
        {
            this._pageIndex = pageIndex;
            this._pageSize = pageSize;
            this._totalRecord = totalRecord;
            this._halfBarSize = halfBarSize;
            this._formId = formId;
            this._containerId = containerId;
            this._totalPage = this._totalRecord % this._pageSize == 0 ? this._totalRecord / this._pageSize : this._totalRecord / this._pageSize + 1;
            this._totalPage = this._totalPage < 1 ? 1 : this._totalPage;

            BuildPageBar();
        }

        private void BuildPageBar()
        {
            _builder.AppendFormat("<div class=\"form-inline gridpager\" form=\"{0}\">", _formId);

            #region 页面、跳转框

            _builder.Append("<select class=\"size form-control\">");
            foreach (var size in _sizeArray)
            {
                if (size == _pageSize)
                    _builder.AppendFormat("<option selected>{0}/页</option>", size);
                else
                    _builder.AppendFormat("<option value={0}>{0}/页</option>", size);
            }
            _builder.Append("</select>").AppendLine();

            _builder.Append("<div class=\"input-group\">");
            _builder.Append("<input formid='#" + _formId + "' value='"+_pageIndex+"' type=\"text\" class=\"goto form-control input-xsmall small\" placeholder=\"第几页\">");
            _builder.Append("<span class=\"input-group-btn\">");
            _builder.Append("<button formid='#"+_formId+"' class=\"goto btn btn-default\" type=\"button\">GO</button>");
            _builder.Append("</span>");
            _builder.Append("</div>");
            _builder.AppendFormat("<input type='hidden' class='timelyTotalPage' timelytotalpage='{0}' />", _totalPage);
            #endregion

            #region 分页

            _builder.Append("<ul class=\"gridpager pagination pull-right margin-top-0\">");
            _builder.AppendFormat("<li class=\"disabled\"><a>{0}条记录 共{1}页 {2}条/页</a></li>", _totalRecord, _totalPage, _pageSize);

            if(_pageIndex > 1)
                _builder.AppendFormat("<li><a p=1>首页</a></li>");
            else
                _builder.AppendFormat("<li class=\"disabled\"><a p={0}>首页</a></li>", _pageIndex);

            if(_pageIndex > 1)
                _builder.AppendFormat("<li><a p={0}>上页</a></li>", _pageIndex - 1);
            else
                _builder.AppendFormat("<li class=\"disabled\"><a>上页</a></li>");

            var startIndex = _pageIndex - _halfBarSize;
            startIndex = startIndex < 1 ? 1 : startIndex;
            var endIndex = _pageIndex + _halfBarSize;
            endIndex = endIndex > _totalPage ? _totalPage : endIndex;
            for (int i = startIndex; i <= endIndex; i++)
            {
                if(i == _pageIndex)
                    _builder.AppendFormat("<li class=\"active\"><a>{0}</a></li>", i);
                else
                    _builder.AppendFormat("<li><a p={0}>{0}</a></li>", i);
            }

            if(_pageIndex < _totalPage)
                _builder.AppendFormat("<li><a p={0}>下页</a></li>", _pageIndex + 1);
            else
                _builder.AppendFormat("<li class=\"disabled\"><a>下页</a></li>");

            if(_pageIndex >= _totalPage)
                _builder.AppendFormat("<li class=\"disabled\"><a>末页</a></li>");
            else
                _builder.AppendFormat("<li><a p={0}>末页</a></li>", _totalPage);

            _builder.Append("</ul>");

            #endregion

            _builder.Append("</div>");
        }

        public string ToHtmlString()
        {
            return _builder.ToString();
        }
    }
}