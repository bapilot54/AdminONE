<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/AdminOne.Master" CodeBehind="Checkout.aspx.vb" Inherits="AdminOne.Checkout" %>

<%@ Register Assembly="DevExpress.Web.Bootstrap.v17.1, Version=17.1.4.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.Bootstrap" TagPrefix="dx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <script type="text/javascript">
        function UpdateDetailGrid(s, e) {
            ASPxCallbackPanel1.PerformCallback();
        }
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BreadrumbActionArea" runat="server">
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="body" runat="server">

    <div class="ibox">
        <div class="ibox-title">
            <h5>Select / Create a Vendor</h5>
            <div class="ibox-tools">
                <a class="collapse-link">
                    <i class="fa fa-chevron-up"></i>
                </a>
            </div>
        </div>
        <div class="ibox-content" style="display: block;">
            <div class="row">
                <div class="col-md-12">

                    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
                        <ContentTemplate>

                            <%-- Options --%>
                            <div class="row">
                                <div class="col-md-12">
                                    <dx:ASPxButton ID="btn_SelectVendor" runat="server" CssClass="m-r" Text="Select a Vendor" AutoPostBack="true" OnClick="btn_SelectVendor_Click"></dx:ASPxButton>
                                    <dx:ASPxButton ID="btn_clearVendor" runat="server" Text="Clear Vendor Fields" AutoPostBack="true"></dx:ASPxButton>
                                </div>
                            </div>

                            <hr />

                            <%-- New Vendor --%>
                            <div class="row">
                                <div class="col-md-6">

                                    <dx:ASPxTextBox ID="tb_vendorName" runat="server" Width="100%" Caption="Name" CaptionSettings-Position="Top">
                                        <ValidationSettings Display="Dynamic" ErrorDisplayMode="ImageWithTooltip" ValidationGroup="newVendor">
                                            <RequiredField IsRequired="true" ErrorText="Vendor Name is required" />
                                        </ValidationSettings>
                                    </dx:ASPxTextBox>

                                    <dx:ASPxTextBox ID="tb_vendorAddress" runat="server" Width="100%" Caption="Address" CaptionSettings-Position="Top">
                                        <ValidationSettings Display="Dynamic" ErrorDisplayMode="ImageWithTooltip" ValidationGroup="newVendor">
                                            <RequiredField IsRequired="true" ErrorText="Vendor Address is required" />
                                        </ValidationSettings>
                                    </dx:ASPxTextBox>

                                    <dx:ASPxTextBox ID="tb_vendorAddress2" runat="server" Width="100%" Caption="Address (Cont)" CaptionSettings-Position="Top">
                                        <ValidationSettings Display="Dynamic" ErrorDisplayMode="ImageWithTooltip" ValidationGroup="newVendor">
                                            <RequiredField IsRequired="true" ErrorText="Vendor Address (Cont) is required" />
                                        </ValidationSettings>
                                    </dx:ASPxTextBox>

                                    <dx:ASPxTextBox ID="tb_vendorPostCode" runat="server" Width="250px" Caption="PostCode" CaptionSettings-Position="Top">
                                        <ValidationSettings Display="Dynamic" ErrorDisplayMode="ImageWithTooltip" ValidationGroup="newVendor">
                                            <RequiredField IsRequired="true" ErrorText="Vendor PostCode is required" />
                                        </ValidationSettings>
                                    </dx:ASPxTextBox>

                                    <dx:ASPxComboBox ID="combo_vendorState" runat="server" Width="250px" Caption="State" CaptionSettings-Position="Top" ValueType="System.String">
                                        <ValidationSettings Display="Dynamic" ErrorDisplayMode="ImageWithTooltip" ValidationGroup="newVendor">
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
                                        <ValidationSettings Display="Dynamic" ErrorDisplayMode="ImageWithTooltip" ValidationGroup="newVendor">
                                            <RequiredField IsRequired="true" ErrorText="Vendor Country is required" />
                                        </ValidationSettings>
                                        <Items>
                                            <dx:ListEditItem Text="Australia" Value="Australia" />
                                            <dx:ListEditItem Text="New Zealand" Value="New Zealand" />
                                        </Items>
                                    </dx:ASPxComboBox>

                                </div>
                            </div>

                        </ContentTemplate>
                    </asp:UpdatePanel>

                    <%-- Modal Select Vendor --%>
                    <div class="modal inmodal fade" id="modal_selectVendorShow" tabindex="-1" role="dialog" aria-hidden="true">
                        <div class="modal-dialog modal-lg">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                                    <h4 class="modal-title">Select a Verified Vendor</h4>
                                </div>
                                <div class="modal-body">

                                    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                        <ContentTemplate>

                                            <dx:ASPxGridView ID="gv_selectVendor" runat="server" Width="100%" AutoGenerateColumns="False" KeyFieldName="ID" SettingsPager-Mode="ShowPager" SettingsSearchPanel-ShowApplyButton="True" SettingsSearchPanel-ShowClearButton="True" SettingsSearchPanel-AllowTextInputTimer="True">
                                                <SettingsAdaptivity AdaptivityMode="HideDataCells"></SettingsAdaptivity>

                                                <SettingsBehavior AllowFocusedRow="True" AllowSelectSingleRowOnly="True"></SettingsBehavior>

                                                <SettingsDataSecurity AllowEdit="False" AllowDelete="False" AllowInsert="False"></SettingsDataSecurity>

                                                <SettingsSearchPanel Visible="True"></SettingsSearchPanel>
                                                <Columns>
                                                    <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0"></dx:GridViewCommandColumn>
                                                    <dx:GridViewDataTextColumn FieldName="ID" ReadOnly="True" VisibleIndex="3" Visible="False"></dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn FieldName="Address" VisibleIndex="2"></dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn FieldName="Address2" VisibleIndex="4" Visible="False"></dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn FieldName="PostCode" VisibleIndex="5" Visible="False"></dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn FieldName="State" VisibleIndex="6" Visible="False"></dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn FieldName="Country" VisibleIndex="7" Visible="False"></dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn FieldName="VendorName" VisibleIndex="1"></dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn FieldName="SAP" VisibleIndex="8" Visible="False"></dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataCheckColumn FieldName="Active" VisibleIndex="9" Visible="False"></dx:GridViewDataCheckColumn>
                                                    <dx:GridViewDataCheckColumn FieldName="Verified" VisibleIndex="10" Visible="False"></dx:GridViewDataCheckColumn>
                                                </Columns>
                                            </dx:ASPxGridView>

                                        </ContentTemplate>
                                    </asp:UpdatePanel>

                                    <asp:SqlDataSource runat="server" ID="ds_vendors" ConnectionString='<%$ ConnectionStrings:DB8874_adminoneConnectionString %>' SelectCommand="SELECT * FROM [Vendors] WHERE (([Verified] = @Verified) AND ([Active] = @Active)) ORDER BY [VendorName]">
                                        <SelectParameters>
                                            <asp:Parameter DefaultValue="True" Name="Verified" Type="Boolean"></asp:Parameter>
                                            <asp:Parameter DefaultValue="True" Name="Active" Type="Boolean"></asp:Parameter>
                                        </SelectParameters>
                                    </asp:SqlDataSource>

                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-white" data-dismiss="modal">Cancel</button>
                                    <dx:ASPxButton ID="btn_selectVendorConfirm" runat="server" CssClass="btn btn-primary" Text="Select" Native="true" AutoPostBack="true" UseSubmitBehavior="false" data-dismiss="modal"></dx:ASPxButton>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>

</asp:Content>
