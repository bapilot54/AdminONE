<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/AdminOne.Master" CodeBehind="AdminControl.aspx.vb" Inherits="AdminOne.AdminControl1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BreadrumbActionArea" runat="server">
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="body" runat="server">

    <div class="ibox">
        <div class="ibox-title">
            <h5>User Administration</h5>
            <div class="ibox-tools">
                <a class="collapse-link">
                    <i class="fa fa-chevron-up"></i>
                </a>
            </div>
        </div>
        <div class="ibox-content" style="display: block;">
            <div class="row">
                <div class="col-sm-12">

                    <a href="/Administration/Site/UserAccounts/CreateEditUserAccounts.aspx">
                        <dx:ASPxButton ID="btncreateEditUserAccounts" runat="server" CssClass="btn btn-w-m btn-primary m-b m-t" Text="Create / Edit User Accounts" Native="true" UseSubmitBehavior="false"></dx:ASPxButton>
                    </a>

                </div>
            </div>
        </div>
    </div>

</asp:Content>
