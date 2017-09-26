<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/AdminOne.Master" CodeBehind="TimeLine.aspx.vb" Inherits="AdminOne.TimeLine" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BreadrumbActionArea" runat="server">
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="body" runat="server">

    <asp:HiddenField ID="hidden_InstallationID" runat="server" />

    <div class="ibox-content" id="ibox-content">

        <asp:Repeater ID="Repeater" runat="server" DataSourceID="ds_repeater">

            <HeaderTemplate>
                <div id="vertical-timeline" class="vertical-container dark-timeline">
            </HeaderTemplate>

            <ItemTemplate>
                <div class="vertical-timeline-block">
                    <div class="vertical-timeline-icon navy-bg">
                        <i class="fa fa-briefcase"></i>
                    </div>

                    <div class="vertical-timeline-content">
                        <fieldset>
                            <legend class="h5" style="line-height: 2 !important"><%# Eval("StageDescription") %>
                            </legend>
                        </fieldset>
                        <p>
                            <asp:Literal ID="literal_Label" runat="server"></asp:Literal>
                        </p>
                        <dx:ASPxButton ID="btn_main" runat="server" CssClass="btn btn-sm btn-success" Native="true" CommandName='<%#Eval("StepNumber") %>' AutoPostBack="true" Text='<%# Eval("MainButtonText") %>'></dx:ASPxButton>
                        <span class="vertical-date"><%# Eval("UpdatedBy") %>
                            <br>
                            <small><%# Eval("UpdatedDateTime") %></small>
                        </span>
                    </div>
                </div>
            </ItemTemplate>

            <FooterTemplate>
                </div>
            </FooterTemplate>

        </asp:Repeater>

        <asp:SqlDataSource runat="server" ID="ds_repeater" ConnectionString='<%$ ConnectionStrings:DB8874_adminoneConnectionString %>' SelectCommand="SELECT ForumInstallationDetails.*, ForumStages.* FROM ForumInstallationDetails INNER JOIN ForumStages ON ForumInstallationDetails.InstallationID = ForumStages.InstallationID WHERE (ForumInstallationDetails.InstallationID = @InstallationID) ORDER BY ForumStages.StepNumber">
            <SelectParameters>
                <asp:Parameter Name="InstallationID"></asp:Parameter>
            </SelectParameters>
        </asp:SqlDataSource>


    </div>

</asp:Content>
