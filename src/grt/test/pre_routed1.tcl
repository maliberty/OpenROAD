# pre routed nets
source "helpers.tcl"
read_liberty "sky130hs/sky130hs_tt.lib"
read_lef "sky130hs/sky130hs.tlef"
read_lef "sky130hs/sky130hs_std_cell.lef"

read_def "pre_routed1.def"

current_design gcd
create_clock -name core_clock -period 2.0000 -waveform {0.0000 1.0000} [get_ports {clk}]
set_propagated_clock [get_clocks {core_clock}]

set guide_file [make_result_file pre_routed1.guide]

set_global_routing_layer_adjustment met1 0.8
set_global_routing_layer_adjustment met2 0.7
set_global_routing_layer_adjustment * 0.5

set_routing_layers -signal met1-met5 -clock met3-met5

global_route

write_guides $guide_file

diff_file pre_routed1.guideok $guide_file
