<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/AdminOne.Master" CodeBehind="Installations.aspx.vb" Inherits="AdminOne.Installations" %>

<%@ Register Assembly="DevExpress.Web.v17.1, Version=17.1.4.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BreadrumbActionArea" runat="server">
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="body" runat="server">


    <%-- Options --%>
    <div class="row m-b">
        <div class="col-sm-12">

            <asp:Button ID="btn_createNewInstallation" runat="server" CssClass="btn btn-w-m btn-primary" Text="Create a New Installation" OnClick="btn_createNewInstallation_Click" />

        </div>
    </div>


    <%-- Active Installations --%>
    <div class="ibox">
        <div class="ibox-title">
            <h5>Active Installations</h5>
            <div class="ibox-tools">
                <a class="collapse-link">
                    <i class="fa fa-chevron-up"></i>
                </a>
            </div>
        </div>
        <div class="ibox-content" style="display: block;">
            <div class="row">
                <div class="col-sm-12">
                    <dx:ASPxGridView ID="gv_activeInstallations" runat="server" Width="100%" AutoGenerateColumns="False" DataSourceID="ds_forumInstallations" KeyFieldName="ID" EnableCallBacks="false">
                        <SettingsAdaptivity AdaptivityMode="HideDataCells"></SettingsAdaptivity>
                        <SettingsSearchPanel Visible="True"></SettingsSearchPanel>
                        <Columns>
                            <dx:GridViewDataTextColumn FieldName="ID" ReadOnly="True" VisibleIndex="0" Visible="false"></dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="InstallationID" VisibleIndex="2"></dx:GridViewDataTextColumn>
                            <dx:GridViewDataDateColumn FieldName="CreatedDateTime" VisibleIndex="5"></dx:GridViewDataDateColumn>
                            <dx:GridViewDataTextColumn FieldName="CreatedBy" VisibleIndex="4"></dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="VendorName" VisibleIndex="3"></dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="ZeissSalesPerson" VisibleIndex="6"></dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="ZeissEngineer" VisibleIndex="7"></dx:GridViewDataTextColumn>
                            <dx:GridViewCommandColumn ButtonRenderMode="Button" ButtonType="button" VisibleIndex="1" Caption="Options" Width="120px">
                                <CustomButtons>
                                    <dx:GridViewCommandColumnCustomButton ID="Edit" Text="Edit"></dx:GridViewCommandColumnCustomButton>
                                    <dx:GridViewCommandColumnCustomButton ID="TimeLine" Text="TimeLine"></dx:GridViewCommandColumnCustomButton>
                                </CustomButtons>
                            </dx:GridViewCommandColumn>
                            <dx:GridViewDataProgressBarColumn FieldName="PercentageComplete" VisibleIndex="8">
                                <PropertiesProgressBar DisplayFormatString=""></PropertiesProgressBar>
                            </dx:GridViewDataProgressBarColumn>
                        </Columns>
                    </dx:ASPxGridView>

                    <asp:SqlDataSource runat="server" ID="ds_forumInstallations" ConnectionString='<%$ ConnectionStrings:DB8874_adminoneConnectionString %>' SelectCommand="SELECT [ID], [InstallationID], [PercentageComplete], [CreatedDateTime], [CreatedBy], [VendorName], [ZeissSalesPerson], [ZeissEngineer] FROM [ForumInstallationDetails] ORDER BY [CreatedDateTime] DESC"></asp:SqlDataSource>
                </div>
            </div>
        </div>
    </div>


    <%-- Completed Installations --%>
    <div class="ibox">
        <div class="ibox-title">
            <h5>Completed Installations</h5>
            <div class="ibox-tools">
                <a class="collapse-link">
                    <i class="fa fa-chevron-up"></i>
                </a>
            </div>
        </div>
        <div class="ibox-content" style="display: block;">
            <div class="row">
                <div class="col-sm-12">
                    <dx:ASPxGridView ID="gv_completedInstallations" runat="server" Width="100%"></dx:ASPxGridView>
                </div>
            </div>
        </div>
    </div>


</asp:Content>
