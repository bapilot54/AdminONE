<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/AdminOne.Master" CodeBehind="AdminControl.aspx.vb" Inherits="AdminOne.AdminControl" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BreadrumbActionArea" runat="server">
</asp:Content>


<asp:Content ID="Content3" ContentPlaceHolderID="body" runat="server">

    <%-- Forum Administration --%>
    <div class="ibox">
        <div class="ibox-title">
            <h5>FORUM Administration</h5>
            <div class="ibox-tools">
                <a class="collapse-link">
                    <i class="fa fa-chevron-up"></i>
                </a>
            </div>
        </div>
        <div class="ibox-content" style="display: block;">
            <div class="row">
                <div class="col-sm-12">

                    <a href="/Administration/Medical/Forum/ForumSiteSurveyProductLinks.aspx">
                        <dx:ASPxButton ID="btn_forumSiteSurveyProductLinks" runat="server" CssClass="btn btn-w-m btn-primary m-b m-t" Text="FORUM Site Survey Product Links" Native="true" UseSubmitBehavior="false"></dx:ASPxButton>
                    </a>

                </div>
            </div>
        </div>
    </div>


    <%-- Product Administration --%>
    <div class="ibox">
        <div class="ibox-title">
            <h5>Product Administration</h5>
            <div class="ibox-tools">
                <a class="collapse-link">
                    <i class="fa fa-chevron-up"></i>
                </a>
            </div>
        </div>
        <div class="ibox-content" style="display: block;">
            <div class="row">
                <div class="col-sm-12">

                    <a href="/Administration/Medical/Products/ProductGroups.aspx">
                        <dx:ASPxButton ID="btn_productGroups" runat="server" CssClass="btn btn-w-m btn-primary m-b m-t" Text="Product Groups" Native="true" UseSubmitBehavior="false"></dx:ASPxButton>
                    </a>

                        <a href="/Administration/Medical/Products/ProductAdministration.aspx">
                        <dx:ASPxButton ID="btn_productAdministration" runat="server" CssClass="btn btn-w-m btn-primary m-b m-t" Text="Product Administration" Native="true" UseSubmitBehavior="false"></dx:ASPxButton>
                    </a>

                </div>
            </div>
        </div>
    </div>

</asp:Content>
