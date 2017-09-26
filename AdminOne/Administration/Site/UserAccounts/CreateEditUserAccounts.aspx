<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/AdminOne.Master" CodeBehind="CreateEditUserAccounts.aspx.vb" Inherits="AdminOne.CreateEditUserAccounts" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BreadrumbActionArea" runat="server">
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="body" runat="server">

    <div class="row">
        <div class="col-sm-12">

            <%-- Create New User --%>
            <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
                <ContentTemplate>

                    <div class="ibox">
                        <div class="ibox-title">
                            <h5>Create a New User Account with Roles</h5>
                            <div class="ibox-tools">
                                <a class="collapse-link">
                                    <i class="fa fa-chevron-up"></i>
                                </a>
                            </div>
                        </div>
                        <div class="ibox-content" style="display: block;">
                            <div class="row">

                                <%-- New User Details --%>
                                <div class="col-sm-6">
                                    <fieldset>
                                        <legend class="h5 m-b" style="line-height: 2 !important">New User Details
                                        </legend>
                                    </fieldset>

                                    <dx:ASPxTextBox ID="tb_newFirstName" runat="server" NullText="Enter FirstName..." Width="100%" Caption="FirstName" CaptionSettings-Position="Top">
                                        <ValidationSettings ValidationGroup="newUser" ErrorDisplayMode="None" Display="Dynamic">
                                            <RequiredField IsRequired="true" ErrorText="FirstName is required" />
                                        </ValidationSettings>
                                    </dx:ASPxTextBox>

                                    <dx:ASPxTextBox ID="tb_newLastName" runat="server" NullText="Enter LastName..." Width="100%" Caption="LastName" CaptionSettings-Position="Top">
                                        <ValidationSettings ValidationGroup="newUser" ErrorDisplayMode="None" Display="Dynamic">
                                            <RequiredField IsRequired="true" ErrorText="LastName is required" />
                                        </ValidationSettings>
                                    </dx:ASPxTextBox>

                                    <dx:ASPxTextBox ID="tb_newEmail" runat="server" NullText="Enter Email Address..." Width="100%" Caption="Email Address" CaptionSettings-Position="Top">
                                        <ValidationSettings ValidationGroup="newUser" ErrorDisplayMode="None" Display="Dynamic">
                                            <RequiredField IsRequired="true" ErrorText="Email Address is required" />
                                            <RegularExpression ErrorText="Invalid Email Address" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" />
                                        </ValidationSettings>
                                    </dx:ASPxTextBox>

                                    <dx:ASPxTextBox ID="tb_newNumber" runat="server" NullText="Enter Contact Number..." Width="100%" Caption="Contact Number" CaptionSettings-Position="Top">
                                        <ValidationSettings ValidationGroup="newUser" ErrorDisplayMode="None" Display="Dynamic">
                                            <RequiredField IsRequired="true" ErrorText="Contact Number is required" />
                                        </ValidationSettings>
                                        <MaskSettings Mask="+99 (99) 99999999" IncludeLiterals="None" />
                                    </dx:ASPxTextBox>

                                    <dx:ASPxComboBox ID="combo_newReportingDivision" runat="server" Width="250px" CssClass="overflow-visible" NullText="Select a Reporting Division..." Caption="Reporting Division" CaptionSettings-Position="Top" DataSourceID="ds_reportingDivision" TextField="DivisionName" ValueField="DivisionName">
                                        <ClearButton DisplayMode="Always"></ClearButton>
                                        <ValidationSettings ValidationGroup="newUser" ErrorDisplayMode="None" Display="Dynamic">
                                            <RequiredField IsRequired="true" ErrorText="Reporting Division is required" />
                                        </ValidationSettings>
                                    </dx:ASPxComboBox>
                                    <asp:SqlDataSource runat="server" ID="ds_reportingDivision" ConnectionString='<%$ ConnectionStrings:DB8874_adminoneConnectionString %>' SelectCommand="SELECT * FROM [ReportingDivisions] ORDER BY [DivisionName]"></asp:SqlDataSource>
                                </div>

                                <%-- Roles --%>
                                <div class="col-sm-6">

                                    <fieldset>
                                        <legend class="h5 m-b" style="line-height: 2 !important">New User Roles
                                        </legend>
                                    </fieldset>

                                    <asp:DataList ID="dl_newUserRoles" runat="server">
                                        <ItemTemplate>
                                            <dx:ASPxCheckBox ID="cb_Roles" runat="server" Text='<%# Container.DataItem %>'></dx:ASPxCheckBox>
                                        </ItemTemplate>
                                    </asp:DataList>
                                </div>

                            </div>

                            <div class="row">
                                <div class="col-sm-12">
                                    <div class="form-group">
                                        <dx:ASPxButton ID="btn_newSaveUser" runat="server" CssClass="btn btn-w-m btn-primary m-b m-t pull-right" Native="true" AutoPostBack="true" Text="Save New User" CausesValidation="true" ValidationGroup="newUser" OnClick="btn_newSaveUser_Click"></dx:ASPxButton>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>

                </ContentTemplate>
            </asp:UpdatePanel>


            <%-- Edit User Account --%>
            <asp:UpdatePanel ID="UpdatePanel2" runat="server" UpdateMode="Conditional">
                <ContentTemplate>

                    <div class="ibox">
                        <div class="ibox-title">
                            <h5>Edit a User Account with Roles</h5>
                            <div class="ibox-tools">
                                <a class="collapse-link">
                                    <i class="fa fa-chevron-up"></i>
                                </a>
                            </div>
                        </div>
                        <div class="ibox-content" style="display: block;">
                            <div class="row">

                                <%-- Select a User --%>
                                <div class="col-sm-6">
                                    <fieldset>
                                        <legend class="h5 m-b" style="line-height: 2 !important">Select a User Account
                                        </legend>
                                    </fieldset>

                                    <div class="form-group">
                                        <dx:ASPxComboBox ID="combo_editUserSelect" runat="server" ReadOnly="false" Width="100%" NullText="Select a User Account..." Caption="User Accounts" CaptionSettings-Position="Top" DataSourceID="ds_userAccounts" TextField="UserName" ValueField="UserID" AutoPostBack="true" OnSelectedIndexChanged="combo_editUserSelect_SelectedIndexChanged">
                                            <ClearButton DisplayMode="Always"></ClearButton>
                                            <ValidationSettings ValidationGroup="editUser" ErrorDisplayMode="None" Display="Dynamic">
                                                <RequiredField IsRequired="true" ErrorText="A User Account is required" />
                                            </ValidationSettings>
                                        </dx:ASPxComboBox>
                                        <asp:SqlDataSource runat="server" ID="ds_userAccounts" ConnectionString='<%$ ConnectionStrings:DB8874_adminoneConnectionString %>' SelectCommand="SELECT UserId, UserName FROM dbo.aspnet_Users"></asp:SqlDataSource>
                                    </div>

                                    <hr />

                                    <fieldset>
                                        <legend class="h5 m-b" style="line-height: 2 !important">Existing User Details
                                        </legend>
                                    </fieldset>

                                    <dx:ASPxTextBox ID="tb_editFirstName" runat="server" NullText="Enter FirstName..." Width="100%" Caption="FirstName" CaptionSettings-Position="Top">
                                        <ValidationSettings ValidationGroup="editUser" ErrorDisplayMode="None" Display="Dynamic">
                                            <RequiredField IsRequired="true" ErrorText="FirstName is required" />
                                        </ValidationSettings>
                                    </dx:ASPxTextBox>

                                    <dx:ASPxTextBox ID="tb_editLastName" runat="server" NullText="Enter LastName..." Width="100%" Caption="LastName" CaptionSettings-Position="Top">
                                        <ValidationSettings ValidationGroup="editUser" ErrorDisplayMode="None" Display="Dynamic">
                                            <RequiredField IsRequired="true" ErrorText="LastName is required" />
                                        </ValidationSettings>
                                    </dx:ASPxTextBox>

                                    <dx:ASPxTextBox ID="tb_editEmailAddress" runat="server" NullText="Enter Email Address..." Width="100%" Caption="Email Address" CaptionSettings-Position="Top" ReadOnly="true">
                                        <ValidationSettings ValidationGroup="editUser" ErrorDisplayMode="None" Display="Dynamic">
                                            <RequiredField IsRequired="true" ErrorText="Email Address is required" />
                                            <RegularExpression ErrorText="Invalid Email Address" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" />
                                        </ValidationSettings>
                                    </dx:ASPxTextBox>

                                    <dx:ASPxTextBox ID="tb_editContactNumber" runat="server" NullText="Enter Contact Number..." Width="100%" Caption="Contact Number" CaptionSettings-Position="Top">
                                        <ValidationSettings ValidationGroup="editUser" ErrorDisplayMode="None" Display="Dynamic">
                                            <RequiredField IsRequired="true" ErrorText="Contact Number is required" />
                                        </ValidationSettings>
                                        <MaskSettings Mask="+99 (99) 99999999" IncludeLiterals="None" />
                                    </dx:ASPxTextBox>

                                    <div class="form-group">
                                        <dx:ASPxComboBox ID="combo_editReportDivision" runat="server" Width="250px" NullText="Select a Reporting Division..." Caption="Reporting Division" CaptionSettings-Position="Top" DataSourceID="ds_reportingDivision" TextField="DivisionName" ValueField="DivisionName">
                                            <ValidationSettings ValidationGroup="editUser" ErrorDisplayMode="None" Display="Dynamic">
                                                <RequiredField IsRequired="true" ErrorText="Reporting Division is required" />
                                            </ValidationSettings>
                                        </dx:ASPxComboBox>
                                    </div>

                                </div>

                                <%-- User Details --%>
                                <div class="col-sm-6">
                                    <fieldset>
                                        <legend class="h5 m-b" style="line-height: 2 !important">Existing User Roles
                                        </legend>
                                    </fieldset>

                                    <asp:DataList ID="dl_editUserRoles" runat="server">
                                        <ItemTemplate>
                                            <dx:ASPxCheckBox ID="cb_Roles" runat="server" Text='<%# Container.DataItem %>'></dx:ASPxCheckBox>
                                        </ItemTemplate>
                                    </asp:DataList>
                                </div>

                            </div>

                            <div class="row">
                                <div class="col-sm-12">
                                    <div class="form-group">
                                        <dx:ASPxButton ID="btn_editUserSave" runat="server" CssClass="btn btn-w-m btn-primary m-b m-t pull-right" Text="Save User Changes" Native="true" CausesValidation="true" ValidationGroup="editUser" AutoPostBack="true" OnClick="btn_editUserSave_Click"></dx:ASPxButton>
                                        <dx:ASPxButton ID="btn_editSetUserInactive" runat="server" CssClass="btn btn-w-m btn-warning m-b m-t m-r pull-right" Text="Set User Inactive" Native="true" CausesValidation="true" ValidationGroup="editUser" AutoPostBack="true" OnClick="btn_editSetUserInactive_Click"></dx:ASPxButton>
                                        <dx:ASPxButton ID="btn_editDeleteUser" runat="server" CssClass="btn btn-w-m btn-danger m-b m-t m-r pull-right" Text="Delete User" data-toggle="modal" data-target="#modal_deleteConfirm" Native="true" CausesValidation="false"></dx:ASPxButton>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>


                    <%-- Modal Delete --%>
                    <div class="modal inmodal fade" id="modal_deleteConfirm" tabindex="-1" role="dialog" aria-hidden="true">
                        <div class="modal-dialog modal-lg">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                                    <h4 class="modal-title">Confirm Delete</h4>
                                </div>
                                <div class="modal-body">
                                    <p>
                                        <strong>This operation cannot be reversed</strong><br />
                                        Please confirm that you wish to delete <%= tb_editEmailAddress.Value %>?
                                    </p>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-white" data-dismiss="modal">Cancel</button>
                                    <dx:ASPxButton ID="btn_confirmUserDelete" runat="server" CssClass="btn btn-danger" Text="Delete User" Native="true" AutoPostBack="true" UseSubmitBehavior="false" data-dismiss="modal" OnClick="btn_confirmUserDelete_Click"></dx:ASPxButton>
                                </div>
                            </div>
                        </div>
                    </div>


                </ContentTemplate>
            </asp:UpdatePanel>

        </div>
    </div>

</asp:Content>
