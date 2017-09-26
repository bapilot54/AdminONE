<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/AdminOne.Master" CodeBehind="ForumSiteSurveyProductLinks.aspx.vb" Inherits="AdminOne.ForumSiteSurveyProductLinks" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BreadrumbActionArea" runat="server">
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="body" runat="server">

    <div class="row">

        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>

                <div class="col-md-6">
                    <div class="well">
                        <fieldset>
                            <legend class="h5 m-b" style="line-height: 2 !important">Select the FORUM Survey Element Description</legend>
                        </fieldset>

                        <div class="form-group">
                            <dx:ASPxComboBox ID="combo_surveyElementDescription" runat="server" Width="100%" AutoPostBack="true" OnSelectedIndexChanged="combo_surveyElementDescription_SelectedIndexChanged">
                                <ClearButton DisplayMode="Always"></ClearButton>
                                <ValidationSettings ErrorDisplayMode="None" CausesValidation="false" Display="Dynamic" ErrorText="Required" SetFocusOnError="True">
                                    <RequiredField IsRequired="True"></RequiredField>
                                </ValidationSettings>
                                <Items>
                                    <dx:ListEditItem Text="FORUM Archive and Viewer" Value="FORUM Archive and Viewer" />
                                    <dx:ListEditItem Text="Glaucoma Workplace Main Package" Value="Glaucoma Workplace Main Package" />
                                    <dx:ListEditItem Text="Retina Workplace Main Package" Value="Retina Workplace Main Package" />
                                    <dx:ListEditItem Text="Doctor FORUM Viewer User" Value="Doctor FORUM Viewer User" />
                                    <dx:ListEditItem Text="Doctor Glaucoma Workplace User" Value="Doctor Glaucoma Workplace User" />
                                    <dx:ListEditItem Text="Doctor Retina Workplace User" Value="Doctor Retina Workplace User" />
                                    <dx:ListEditItem Text="Staff FORUM Viewer User" Value="Staff FORUM Viewer User" />
                                    <dx:ListEditItem Text="Carl Zeiss Device Connection" Value="Carl Zeiss Device Connection" />
                                    <dx:ListEditItem Text="3rd Party Device Connection" Value="3rd Party Device Connection" />
                                    <dx:ListEditItem Text="EMR Connectivity" Value="EMR Connectivity" />
                                    <dx:ListEditItem Text="Data Cleanse" Value="Data Cleanse" />
                                </Items>
                            </dx:ASPxComboBox>
                        </div>

                    </div>
                </div>

                <div class="col-md-6">
                    <div class="well">
                        <fieldset>
                            <legend class="h5 m-b" style="line-height: 2 !important">Select the FORUM Database Product</legend>
                        </fieldset>

                        <div class="form-group">
                            <dx:ASPxComboBox ID="combo_surveyProduct" runat="server" DataSourceID="ds_forumProducts" TextField="ProductDescription" ValueField="ID" Width="100%" AutoPostBack="true" OnSelectedIndexChanged="combo_surveyProduct_SelectedIndexChanged">
                                <ClearButton DisplayMode="Always"></ClearButton>
                                <ValidationSettings ErrorDisplayMode="None" CausesValidation="false" Display="Dynamic" ErrorText="Required" SetFocusOnError="True">
                                    <RequiredField IsRequired="True"></RequiredField>
                                </ValidationSettings>
                            </dx:ASPxComboBox>

                            <asp:SqlDataSource runat="server" ID="ds_forumProducts" ConnectionString='<%$ ConnectionStrings:DB8874_adminoneConnectionString %>' SelectCommand="SELECT * FROM [Med_Products] WHERE ([ProductGroup] = @ProductGroup) ORDER BY [ProductDescription]">
                                <SelectParameters>
                                    <asp:Parameter DefaultValue="FORUM" Name="ProductGroup" Type="String"></asp:Parameter>
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </div>

                    </div>
                </div>

                <hr />

                <div class="col-md-12">
                    <fieldset>
                        <legend class="h5 m-b" style="line-height: 2 !important">Selection Overview and Confirm</legend>
                    </fieldset>

                    <div class="form-group">
                        <h4><small>Survey Element :</small></h4>
                        <h5 id="lbl_surveyElement" runat="server">Not Selected</h5>
                    </div>

                    <div class="form-group">
                        <h4><small>Assigned FORUM Product :</small></h4>
                        <h5 id="lbl_forumProduct" runat="server">Not Selected</h5>
                    </div>

                    <div class="form-group">
                        <dx:ASPxButton ID="btn_saveAllocations" runat="server" CssClass="btn btn-w-m btn-primary m-b m-t" Text="Save Allocations" Native="true" OnClick="btn_saveAllocations_Click"></dx:ASPxButton>
                    </div>

                </div>

            </ContentTemplate>
        </asp:UpdatePanel>

    </div>

</asp:Content>
