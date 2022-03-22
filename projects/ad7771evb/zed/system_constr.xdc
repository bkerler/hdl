
#ALERT_B
#SDP_CONVST Start SAR conversion 
#GPIO2

set_property  -dict {PACKAGE_PIN L18  IOSTANDARD LVCMOS25}  [get_ports adc_clk_in]              ; #DCLK_B   
set_property  -dict {PACKAGE_PIN M19  IOSTANDARD LVCMOS25}  [get_ports adc_ready_in]            ; #DRDY_B
set_property  -dict {PACKAGE_PIN M20  IOSTANDARD LVCMOS25}  [get_ports adc_data_in[0]]          ; #DOUT0_B   
set_property  -dict {PACKAGE_PIN L22  IOSTANDARD LVCMOS25}  [get_ports adc_data_in[1]]          ; #DOUT1_B   
set_property  -dict {PACKAGE_PIN P17  IOSTANDARD LVCMOS25}  [get_ports adc_data_in[2]]          ; #DOUT2_B   
set_property  -dict {PACKAGE_PIN P18  IOSTANDARD LVCMOS25}  [get_ports adc_data_in[3]]          ; #DOUT3_B   

set_property  -dict {PACKAGE_PIN J18  IOSTANDARD LVCMOS25}  [get_ports spi_csn]             ; #CS_B 
set_property  -dict {PACKAGE_PIN N19  IOSTANDARD LVCMOS25}  [get_ports spi_clk]             ; #SCLK_B  
set_property  -dict {PACKAGE_PIN M22  IOSTANDARD LVCMOS25}  [get_ports spi_mosi]            ; #SDI_B  
set_property  -dict {PACKAGE_PIN N22  IOSTANDARD LVCMOS25}  [get_ports spi_miso]            ; #SDO_B  


set_property  -dict {PACKAGE_PIN L21  IOSTANDARD LVCMOS25}  [get_ports reset_n]             ; #RESET_B         
set_property  -dict {PACKAGE_PIN P22  IOSTANDARD LVCMOS25}  [get_ports start_n]             ; #START_B         
set_property  -dict {PACKAGE_PIN M21  IOSTANDARD LVCMOS25}  [get_ports sync_n]              ; #SYNC_IN_B      
             

create_clock -name adc_clk -period 20 [get_ports adc_clk_in]
