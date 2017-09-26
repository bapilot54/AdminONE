<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/AdminOne.Master" CodeBehind="NewEditInstallation.aspx.vb" Inherits="AdminOne.NewEditInstallation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BreadrumbActionArea" runat="server">
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="body" runat="server">

    <asp:HiddenField ID="hidden_installationID" runat="server" />

    <%-- Header Details --%>
    <div class="row m-b">

        <div class="col-sm-6">
            <div class="form-group">
                <h4><small>Created By :</small></h4>
                <h5 id="lbl_topCreatedBy" runat="server"></h5>
            </div>
            <div class="form-group">
                <h4><small>Last Edited By :</small></h4>
                <h5 id="lbl_topEditedBy" runat="server"></h5>
            </div>
        </div>

        <div class="col-sm-6">
            <div class="form-group">
                <dx:ASPxButton ID="btn_saveChanges" runat="server" Text="Save Changes" Image-IconID="people_employeethank_16x16devav" CssClass="btn btn-w-m btn-primary m-b pull-right" Native="true" CausesValidation="true" AutoPostBack="true" OnClick="btn_saveChanges_Click">
                </dx:ASPxButton>
            </div>
        </div>

    </div>


    <%-- Zeiss Nominations --%>
    <div class="ibox">
        <div class="ibox-title">
            <h5>Zeiss Nominations</h5>
            <div class="ibox-tools">
                <a class="collapse-link">
                    <i class="fa fa-chevron-up"></i>
                </a>
            </div>
        </div>
        <div class="ibox-content" style="display: block;">
            <div class="row">

                <div class="col-md-6">

                    <dx:ASPxComboBox ID="combo_ZNSalesPerson" runat="server" Width="100%" Caption="FORUM SalesPerson" CaptionSettings-Position="Top" DataSourceID="ds_forumSalesPerson" TextField="UserName" ValueField="UserName">
                        <ValidationSettings Display="Dynamic" ErrorDisplayMode="ImageWithTooltip">
                            <RequiredField IsRequired="true" ErrorText="FORUM SalesPerson is required" />
                        </ValidationSettings>
                    </dx:ASPxComboBox>
                    <asp:SqlDataSource runat="server" ID="ds_forumSalesPerson" ConnectionString='<%$ ConnectionStrings:DB8874_adminoneConnectionString %>' SelectCommand="SELECT dbo.aspnet_Users.UserName FROM dbo.aspnet_Roles INNER JOIN dbo.aspnet_UsersInRoles ON dbo.aspnet_Roles.RoleId = dbo.aspnet_UsersInRoles.RoleId INNER JOIN dbo.aspnet_Users ON dbo.aspnet_UsersInRoles.UserId = dbo.aspnet_Users.UserId WHERE (dbo.aspnet_Roles.RoleName = @RoleName)">
                        <SelectParameters>
                            <asp:Parameter DefaultValue="FORUM SalesPerson" Name="RoleName"></asp:Parameter>
                        </SelectParameters>
                    </asp:SqlDataSource>

                    <dx:ASPxComboBox ID="combo_ZNEngineer" runat="server" Width="100%" Caption="FORUM Engineer" CaptionSettings-Position="Top" DataSourceID="ds_forumEngineer" TextField="UserName" ValueField="UserName">
                        <ValidationSettings Display="Dynamic" ErrorDisplayMode="ImageWithTooltip">
                            <RequiredField IsRequired="true" ErrorText="FORUM Engineer is required" />
                        </ValidationSettings>
                    </dx:ASPxComboBox>
                    <asp:SqlDataSource runat="server" ID="ds_forumEngineer" ConnectionString='<%$ ConnectionStrings:DB8874_adminoneConnectionString %>' SelectCommand="SELECT dbo.aspnet_Users.UserName FROM dbo.aspnet_Roles INNER JOIN dbo.aspnet_UsersInRoles ON dbo.aspnet_Roles.RoleId = dbo.aspnet_UsersInRoles.RoleId INNER JOIN dbo.aspnet_Users ON dbo.aspnet_UsersInRoles.UserId = dbo.aspnet_Users.UserId WHERE (dbo.aspnet_Roles.RoleName = @RoleName)">
                        <SelectParameters>
                            <asp:Parameter DefaultValue="FORUM Engineer" Name="RoleName"></asp:Parameter>
                        </SelectParameters>
                    </asp:SqlDataSource>

                </div>

            </div>
        </div>
    </div>


    <%-- Vendor Details --%>
    <div class="row">
        <div class="col-sm-12">
            <div class="ibox">
                <div class="ibox-title">
                    <h5>Vendor Details</h5>
                    <div class="ibox-tools">
                        <a class="collapse-link">
                            <i class="fa fa-chevron-up"></i>
                        </a>
                    </div>
                </div>
                <div class="ibox-content" style="display: block;">
                    <div class="row">

                        <div class="col-md-6">
                            <div class="form-group">

                                <dx:ASPxTextBox ID="tb_vendorName" runat="server" Width="100%" Caption="Name" CaptionSettings-Position="Top">
                                    <ValidationSettings Display="Dynamic" ErrorDisplayMode="ImageWithTooltip">
                                        <RequiredField IsRequired="true" ErrorText="Vendor Name is required" />
                                    </ValidationSettings>
                                </dx:ASPxTextBox>

                                <dx:ASPxTextBox ID="tb_vendorAddress" runat="server" Width="100%" Caption="Address" CaptionSettings-Position="Top">
                                    <ValidationSettings Display="Dynamic" ErrorDisplayMode="ImageWithTooltip">
                                        <RequiredField IsRequired="true" ErrorText="Vendor Address is required" />
                                    </ValidationSettings>
                                </dx:ASPxTextBox>

                                <dx:ASPxTextBox ID="tb_vendorAddress2" runat="server" Width="100%" Caption="Address (Cont)" CaptionSettings-Position="Top">
                                    <ValidationSettings Display="Dynamic" ErrorDisplayMode="ImageWithTooltip">
                                        <RequiredField IsRequired="true" ErrorText="Vendor Address (Cont) is required" />
                                    </ValidationSettings>
                                </dx:ASPxTextBox>

                                <dx:ASPxTextBox ID="tb_vendorPostCode" runat="server" Width="250px" Caption="PostCode" CaptionSettings-Position="Top">
                                    <ValidationSettings Display="Dynamic" ErrorDisplayMode="ImageWithTooltip">
                                        <RequiredField IsRequired="true" ErrorText="Vendor PostCode is required" />
                                    </ValidationSettings>
                                </dx:ASPxTextBox>

                                <dx:ASPxComboBox ID="combo_vendorState" runat="server" Width="250px" Caption="State" CaptionSettings-Position="Top" ValueType="System.String">
                                    <ValidationSettings Display="Dynamic" ErrorDisplayMode="ImageWithTooltip">
                                        <RequiredField IsRequired="true" ErrorText="Vendor State is required" />
                                    </ValidationSettings>
                                    <Items>
                                        <dx:ListEditItem Text="VIC" Value="VIC" />
                                        <dx:ListEditItem Text="ACT" Value="ACT" />
                                        <dx:ListEditItem Text="NSW" Value="NSW" />
                                        <dx:ListEditItem Text="QLD" Value="QLD" />
                                        <dx:ListEditItem Text="NT" Value="NT" />
                                        <dx:ListEditItem Text="WA" Value="WA" />
                                        <dx:ListEditItem Text="SA" Value="SA" />
                                        <dx:ListEditItem Text="TAS" Value="TAS" />
                                        <dx:ListEditItem Text="NZ" Value="NZ" />
                                    </Items>
                                </dx:ASPxComboBox>

                                <dx:ASPxComboBox ID="combo_vendorCountry" runat="server" Width="250px" Caption="Country" CaptionSettings-Position="Top" ValueType="System.String">
                                    <ValidationSettings Display="Dynamic" ErrorDisplayMode="ImageWithTooltip">
                                        <RequiredField IsRequired="true" ErrorText="Vendor Country is required" />
                                    </ValidationSettings>
                                    <Items>
                                        <dx:ListEditItem Text="Australia" Value="Australia" />
                                        <dx:ListEditItem Text="New Zealand" Value="New Zealand" />
                                    </Items>
                                </dx:ASPxComboBox>

                            </div>
                        </div>

                        <div class="col-md-6">
                            <div class="form-group">

                                <dx:ASPxTextBox ID="tb_vendorContactName" runat="server" Width="100%" Caption="Contact Name" CaptionSettings-Position="Top">
                                    <ValidationSettings Display="Dynamic" ErrorDisplayMode="ImageWithTooltip">
                                        <RequiredField IsRequired="true" ErrorText="Vendor Contact Name is required" />
                                    </ValidationSettings>
                                </dx:ASPxTextBox>

                                <dx:ASPxTextBox ID="tb_vendorContactNumber" runat="server" Width="100%" Caption="Contact Number" CaptionSettings-Position="Top">
                                    <ValidationSettings Display="Dynamic" ErrorDisplayMode="ImageWithTooltip">
                                        <RequiredField IsRequired="true" ErrorText="Vendor Contact Number is required" />
                                    </ValidationSettings>
                                    <MaskSettings Mask="+99 (99) 99999999" IncludeLiterals="None" />
                                </dx:ASPxTextBox>

                                <dx:ASPxTextBox ID="tb_vendorContactEmail" runat="server" Width="100%" Caption="Contact Email" CaptionSettings-Position="Top">
                                    <ValidationSettings Display="Dynamic" ErrorDisplayMode="ImageWithTooltip">
                                        <RequiredField IsRequired="true" ErrorText="Vendor contact Email is required" />
                                        <RegularExpression ErrorText="Invalid Email Address" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" />
                                    </ValidationSettings>
                                </dx:ASPxTextBox>

                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>


    <%-- Pre-Survey --%>
    <div class="ibox">
        <div class="ibox-title">
            <h5>Pre-Survey</h5>
            <div class="ibox-tools">
                <a class="collapse-link">
                    <i class="fa fa-chevron-up"></i>
                </a>
            </div>
        </div>
        <div class="ibox-content" style="display: block;">
            <div class="row">

                <div class="col-md-12">

                    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                        <ContentTemplate>

                            <%-- Main Packages --%>
                            <div class="well">
                                <fieldset>
                                    <legend class="h5 m-b" style="line-height: 2 !important">FORUM Package Inclusions</legend>
                                </fieldset>

                                <div class="form-group">
                                    <dx:ASPxCheckBox ID="cb_archiveAndViewer" runat="server" Text="FORUM Archive and Viewer" Checked="true"></dx:ASPxCheckBox>
                                </div>

                                <div class="form-group">
                                    <dx:ASPxCheckBox ID="cb_glaucomaWorkplaceMain" runat="server" Text="Glaucoma Workplace Main Package" AutoPostBack="true" OnCheckedChanged="cb_glaucomaWorkplaceMain_CheckedChanged"></dx:ASPxCheckBox>
                                </div>

                                <div class="form-group">
                                    <dx:ASPxCheckBox ID="cb_retinaWorkplaceMain" runat="server" Text="Retina Workplace Main Package" AutoPostBack="true" OnCheckedChanged="cb_retinaWorkplaceMain_CheckedChanged"></dx:ASPxCheckBox>
                                </div>
                            </div>

                            <%-- Viewers --%>
                            <div class="well">
                                <fieldset>
                                    <legend class="h5 m-b" style="line-height: 2 !important">Viewer Licences Required</legend>
                                </fieldset>

                                <div class="form-group">
                                    <p>FORUM Main Viewer, Glaucoma Workplace and Retina Workplaces licences are all concurrent user licences, i.e. the number of simultaneous users logged in at any one time</p>
                                    <p>The number of FORUM Viewer Users must include anybody that uses FORUM, Doctors, Orthoptists, Receptions Staff etc... </p>
                                    <p>Workplace Users must have a FORUM Viewer Licence + the relevant Workplace User Licence</p>
                                </div>

                                <div class="form-group">
                                    <dx:ASPxSpinEdit ID="spin_forumViewers" runat="server" Number="0" MinValue="0" MaxValue="100" Caption="FORUM Viewer Users Required" CaptionSettings-Position="Left">
                                    </dx:ASPxSpinEdit>
                                </div>

                                <div class="form-group">
                                    <dx:ASPxSpinEdit ID="spin_glaucomaWorkplaceUsers" runat="server" Number="0" MinValue="0" MaxValue="100" Caption="Glaucoma Workplace Users Required" CaptionSettings-Position="Left" Visible="false">
                                    </dx:ASPxSpinEdit>
                                </div>

                                <div class="form-group">
                                    <dx:ASPxSpinEdit ID="spin_retinaWorkplaceUsers" runat="server" Number="0" MinValue="0" MaxValue="100" Caption="Retina Workplace Users Required" CaptionSettings-Position="Left" Visible="false">
                                    </dx:ASPxSpinEdit>
                                </div>
                            </div>

                        </ContentTemplate>
                    </asp:UpdatePanel>

                    <%-- Device Connections --%>
                    <div class="well">
                        <fieldset>
                            <legend class="h5 m-b" style="line-height: 2 !important">Instrument Connections</legend>
                        </fieldset>

                        <div class="form-group">
                            <dx:ASPxSpinEdit ID="spin_zeissDeviceConnections" runat="server" Number="0" MinValue="0" MaxValue="100" Caption="Carl Zeiss Devices to be Connected" CaptionSettings-Position="Left">
                            </dx:ASPxSpinEdit>
                        </div>

                        <hr />

                        <div class="form-group">
                            <p>Each 3rd Party Device will require an individual Connection Licence to FORUM, the Instrument DICOM connection will be used for the purpose of the Pre-Survey</p>
                        </div>

                        <div class="form-group">
                            <dx:ASPxSpinEdit ID="spin_thirdPartyDeviceConnections" runat="server" Number="0" MinValue="0" MaxValue="100" Caption="3rd Party Devices to be Connected" CaptionSettings-Position="Left">
                            </dx:ASPxSpinEdit>
                        </div>
                    </div>

                    <%-- EMR --%>
                    <div class="well">
                        <fieldset>
                            <legend class="h5 m-b" style="line-height: 2 !important">EMR Connectivity</legend>
                        </fieldset>

                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                            <ContentTemplate>

                                <div class="form-group">
                                    <dx:ASPxCheckBox ID="cb_emrRequired" runat="server" Text="EMR Integration Required" AutoPostBack="true" OnCheckedChanged="cb_emrRequired_CheckedChanged"></dx:ASPxCheckBox>
                                </div>

                                <div class="form-group">
                                    <dx:ASPxComboBox ID="combo_EMRVendors" runat="server" Width="250px" DataSourceID="ds_emrVendors" TextField="VendorName" ValueField="VendorName" Caption="Supported EMR Vendors" CaptionSettings-Position="Left" AutoPostBack="true" OnSelectedIndexChanged="combo_EMRVendors_SelectedIndexChanged" Visible="false">
                                        <ClearButton DisplayMode="Always"></ClearButton>
                                    </dx:ASPxComboBox>
                                    <asp:SqlDataSource runat="server" ID="ds_emrVendors" ConnectionString='<%$ ConnectionStrings:DB8874_adminoneConnectionString %>' SelectCommand="SELECT * FROM [ForumEMRSelection] ORDER BY [VendorName]"></asp:SqlDataSource>
                                </div>

                                <div class="form-group">
                                    <dx:ASPxCheckBox ID="cb_dataCleanseRequired" runat="server" Text="Data Cleanse Required" Visible="false"></dx:ASPxCheckBox>
                                </div>

                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>

                    <%-- Notes --%>
                    <div class="well">
                        <fieldset>
                            <legend class="h5 m-b" style="line-height: 2 !important">Notes and Requests</legend>
                        </fieldset>

                        <div class="form-group">
                            <p>If you require clarification of any element on the Pre-Survey, please contact your nominated FORUM Engineer. Notes can be made below and will be visible to all involved in the Project.</p>
                        </div>

                        <div class="form-group">
                            <dx:ASPxMemo ID="tb_notesandRequests" runat="server" Height="200px" Width="100%"></dx:ASPxMemo>
                        </div>
                    </div>

                </div>

            </div>
        </div>
    </div>


</asp:Content>
