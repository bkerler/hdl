


set_property  -dict {PACKAGE_PIN L18   IOSTANDARD LVCMOS25}  [get_ports adc_clk_in]     ; #DCLK_B       CLK0_M2C_P
set_property  -dict {PACKAGE_PIN M19   IOSTANDARD LVCMOS25}  [get_ports adc_ready_in]   ; #DRDY_B       LA00_P
set_property  -dict {PACKAGE_PIN M20   IOSTANDARD LVCMOS25}  [get_ports adc_data_in[0]] ; #DOUT0_B      LA00_N
set_property  -dict {PACKAGE_PIN L22   IOSTANDARD LVCMOS25}  [get_ports adc_data_in[1]] ; #DOUT1_B      LA06_N 
set_property  -dict {PACKAGE_PIN P17   IOSTANDARD LVCMOS25}  [get_ports adc_data_in[2]] ; #DOUT2_B      LA02_P
set_property  -dict {PACKAGE_PIN P18   IOSTANDARD LVCMOS25}  [get_ports adc_data_in[3]] ; #DOUT3_B      LA02_N

set_property  -dict {PACKAGE_PIN J18  IOSTANDARD LVCMOS25}  [get_ports spi_csn]        ; #CS_B         LA05_P
set_property  -dict {PACKAGE_PIN N19  IOSTANDARD LVCMOS25}  [get_ports spi_clk]        ; #SCLK_B       LA01_P
set_property  -dict {PACKAGE_PIN M22  IOSTANDARD LVCMOS25}  [get_ports spi_mosi]       ; #SDI_B        LA04_N
set_property  -dict {PACKAGE_PIN N22  IOSTANDARD LVCMOS25}  [get_ports spi_miso]       ; #SDO_B        LA03_P


set_property  -dict {PACKAGE_PIN L21  IOSTANDARD LVCMOS25}  [get_ports reset_n]         ; #RESET_B     LA06_P  
set_property  -dict {PACKAGE_PIN P22  IOSTANDARD LVCMOS25}  [get_ports start_n]         ; #START_B     LA03_N 
set_property  -dict {PACKAGE_PIN M21  IOSTANDARD LVCMOS25}  [get_ports sync_n]          ; #SYNC_IN_B   LA04_P 
set_property  -dict {PACKAGE_PIN R19  IOSTANDARD LVCMOS25}  [get_ports alert]           ; #ALERT_B     LA10_P
set_property  -dict {PACKAGE_PIN R20  IOSTANDARD LVCMOS25}  [get_ports sdp_convst]      ; #SDP_CONVST  LA09_P
set_property  -dict {PACKAGE_PIN A22  IOSTANDARD LVCMOS25}  [get_ports gpio2]           ; #GPIO2       LA32_N 
set_property  -dict {PACKAGE_PIN N20   IOSTANDARD LVCMOS25}  [get_ports sdp_mclk]        ; #SDP_MCLK    LA01_N
             

create_clock -name adc_clk -period 122.07 [get_ports adc_clk_in]
