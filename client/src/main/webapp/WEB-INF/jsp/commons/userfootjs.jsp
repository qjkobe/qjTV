<!-- BEGIN JAVASCRIPTS(Load javascripts at bottom, this will reduce page load time) -->
<!-- BEGIN CORE PLUGINS -->
<script src="${ctx}/theme/assets/global/plugins/jquery-migrate.min.js" type="text/javascript"></script>
<!-- IMPORTANT! Load jquery-ui.min.js before bootstrap.min.js to fix bootstrap tooltip conflict with jquery ui tooltip -->
<script src="${ctx}/theme/assets/global/plugins/jquery-ui/jquery-ui.min.js" type="text/javascript"></script>
<script src="${ctx}/theme/assets/global/plugins/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
<script src="${ctx}/theme/assets/global/plugins/jquery-slimscroll/jquery.slimscroll.min.js" type="text/javascript"></script>
<script src="${ctx}/theme/assets/global/plugins/jquery.blockui.min.js" type="text/javascript"></script>
<script src="${ctx}/theme/assets/global/plugins/jquery.cokie.min.js" type="text/javascript"></script>
<script src="${ctx}/theme/assets/global/plugins/uniform/jquery.uniform.min.js" type="text/javascript"></script>
<script src="${ctx}/theme/assets/global/plugins/bootstrap-switch/js/bootstrap-switch.min.js" type="text/javascript"></script>
<!-- END CORE PLUGINS -->
<!-- BEGIN PAGE LEVEL PLUGINS -->
<script src="${ctx}/theme/assets/global/plugins/flot/jquery.flot.min.js" type="text/javascript"></script>
<script src="${ctx}/theme/assets/global/plugins/flot/jquery.flot.resize.min.js" type="text/javascript"></script>
<script src="${ctx}/theme/assets/global/plugins/flot/jquery.flot.categories.min.js" type="text/javascript"></script>
<script src="${ctx}/theme/assets/global/plugins/jquery.pulsate.min.js" type="text/javascript"></script>
<script src="${ctx}/theme/assets/global/plugins/bootstrap-daterangepicker/moment.min.js" type="text/javascript"></script>
<script src="${ctx}/theme/assets/global/plugins/bootstrap-daterangepicker/daterangepicker.js" type="text/javascript"></script>
<!-- IMPORTANT! fullcalendar depends on jquery-ui.min.js for drag & drop support -->
<script src="${ctx}/theme/assets/global/plugins/fullcalendar/fullcalendar.min.js" type="text/javascript"></script>
<script src="${ctx}/theme/assets/global/plugins/jquery-easypiechart/jquery.easypiechart.min.js" type="text/javascript"></script>
<script src="${ctx}/theme/assets/global/plugins/jquery.sparkline.min.js" type="text/javascript"></script>
<!-- END PAGE LEVEL PLUGINS -->
<!-- BEGIN PAGE LEVEL SCRIPTS -->
<script src="${ctx}/theme/assets/global/scripts/metronic.js" type="text/javascript"></script>
<script src="${ctx}/theme/assets/admin/layout2/scripts/layout.js" type="text/javascript"></script>
<script src="${ctx}/theme/assets/admin/layout2/scripts/quick-sidebar.js" type="text/javascript"></script>
<script src="${ctx}/theme/assets/admin/layout2/scripts/demo.js" type="text/javascript"></script>
<script src="${ctx}/theme/assets/admin/pages/scripts/index.js" type="text/javascript"></script>
<script src="${ctx}/theme/assets/admin/pages/scripts/tasks.js" type="text/javascript"></script>
<!-- END PAGE LEVEL SCRIPTS -->

<script src="${ctx}/theme/assets/global/plugins/jquery.min.js" type="text/javascript"></script>
<script src="${ctx}/theme/assets/global/plugins/jquery-migrate.min.js" type="text/javascript"></script>
<!-- IMPORTANT! Load jquery-ui.min.js before bootstrap.min.js to fix bootstrap tooltip conflict with jquery ui tooltip -->
<script src="${ctx}/theme/assets/global/plugins/jquery-ui/jquery-ui.min.js" type="text/javascript"></script>
<script src="${ctx}/theme/assets/global/plugins/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
<script src="${ctx}/theme/assets/global/plugins/bootstrap-hover-dropdown/bootstrap-hover-dropdown.min.js" type="text/javascript"></script>
<script src="${ctx}/theme/assets/global/plugins/jquery-slimscroll/jquery.slimscroll.min.js" type="text/javascript"></script>
<script src="${ctx}/theme/assets/global/plugins/jquery.blockui.min.js" type="text/javascript"></script>
<script src="${ctx}/theme/assets/global/plugins/jquery.cokie.min.js" type="text/javascript"></script>
<script src="${ctx}/theme/assets/global/plugins/uniform/jquery.uniform.min.js" type="text/javascript"></script>
<script src="${ctx}/theme/assets/global/plugins/bootstrap-switch/js/bootstrap-switch.min.js" type="text/javascript"></script>
<!-- END CORE PLUGINS -->
<!-- BEGIN PAGE LEVEL PLUGINS -->
<script type="text/javascript" src="${ctx}/theme/assets/global/plugins/select2/select2.min.js"></script>
<script type="text/javascript" src="${ctx}/theme/assets/global/plugins/datatables/media/js/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="${ctx}/theme/assets/global/plugins/datatables/extensions/TableTools/js/dataTables.tableTools.min.js"></script>
<script type="text/javascript" src="${ctx}/theme/assets/global/plugins/datatables/extensions/ColReorder/js/dataTables.colReorder.min.js"></script>
<script type="text/javascript" src="${ctx}/theme/assets/global/plugins/datatables/extensions/Scroller/js/dataTables.scroller.min.js"></script>
<script type="text/javascript" src="${ctx}/theme/assets/global/plugins/datatables/plugins/bootstrap/dataTables.bootstrap.js"></script>
<!-- END PAGE LEVEL PLUGINS -->
<!-- BEGIN PAGE LEVEL SCRIPTS -->
<script src="${ctx}/theme/assets/global/scripts/metronic.js" type="text/javascript"></script>
<script src="${ctx}/theme/assets/admin/layout2/scripts/layout.js" type="text/javascript"></script>
<script src="${ctx}/theme/assets/admin/layout2/scripts/demo.js" type="text/javascript"></script>
<script src="${ctx}/theme/assets/admin/pages/scripts/table-advanced.js"></script>
<script>
    jQuery(document).ready(function() {
        Metronic.init(); // init metronic core components
        Layout.init(); // init current layout
        Demo.init(); // init demo features
        TableAdvanced.init();
    });
</script>