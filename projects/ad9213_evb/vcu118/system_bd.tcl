
## FIFO depth is 4Mb - 250k samples (65k samples per converter)
set adc_fifo_address_width 13

source $ad_hdl_dir/projects/common/vcu118/vcu118_system_bd.tcl
source $ad_hdl_dir/projects/common/xilinx/adcfifo_bd.tcl
source ../common/ad9213_evb_bd.tcl
source $ad_hdl_dir/projects/scripts/adi_pd.tcl

# Set SPI clock to 100/16 =  6.25 MHz
ad_ip_parameter axi_spi CONFIG.C_SCK_RATIO 16

#system ID
ad_ip_parameter axi_sysid_0 CONFIG.ROM_ADDR_BITS 9
ad_ip_parameter rom_sys_0 CONFIG.PATH_TO_FILE "[pwd]/mem_init_sys.txt"
ad_ip_parameter rom_sys_0 CONFIG.ROM_ADDR_BITS 9

sysid_gen_sys_init_file

ad_ip_parameter util_adc_xcvr CONFIG.RX_CLK25_DIV 30
ad_ip_parameter util_adc_xcvr CONFIG.CPLL_CFG0 0x1fa
ad_ip_parameter util_adc_xcvr CONFIG.CPLL_CFG1 0x2b
ad_ip_parameter util_adc_xcvr CONFIG.CPLL_CFG2 0x2
ad_ip_parameter util_adc_xcvr CONFIG.CPLL_FBDIV 2
ad_ip_parameter util_adc_xcvr CONFIG.CH_HSPMUX 0x4040
ad_ip_parameter util_adc_xcvr CONFIG.PREIQ_FREQ_BST 1
ad_ip_parameter util_adc_xcvr CONFIG.RTX_BUF_CML_CTRL 0x5
ad_ip_parameter util_adc_xcvr CONFIG.RXPI_CFG0 0x3002
ad_ip_parameter util_adc_xcvr CONFIG.QPLL_REFCLK_DIV 1
ad_ip_parameter util_adc_xcvr CONFIG.QPLL_CFG0 0x333c
ad_ip_parameter util_adc_xcvr CONFIG.QPLL_CFG4 0x2
ad_ip_parameter util_adc_xcvr CONFIG.QPLL_FBDIV 20
ad_ip_parameter util_adc_xcvr CONFIG.PPF0_CFG 0xB00

# Second SPI controller
create_bd_port -dir O -from 7 -to 0 spi_2_csn_o
create_bd_port -dir I -from 7 -to 0 spi_2_csn_i
create_bd_port -dir I spi_2_clk_i
create_bd_port -dir O spi_2_clk_o
create_bd_port -dir I spi_2_sdo_i
create_bd_port -dir O spi_2_sdo_o
create_bd_port -dir I spi_2_sdi_i

ad_ip_instance axi_quad_spi axi_spi_2
ad_ip_parameter axi_spi_2 CONFIG.C_USE_STARTUP 0
ad_ip_parameter axi_spi_2 CONFIG.C_NUM_SS_BITS 8
ad_ip_parameter axi_spi_2 CONFIG.C_SCK_RATIO 8

ad_connect spi_2_csn_i axi_spi_2/ss_i
ad_connect spi_2_csn_o axi_spi_2/ss_o
ad_connect spi_2_clk_i axi_spi_2/sck_i
ad_connect spi_2_clk_o axi_spi_2/sck_o
ad_connect spi_2_sdo_i axi_spi_2/io0_i
ad_connect spi_2_sdo_o axi_spi_2/io0_o
ad_connect spi_2_sdi_i axi_spi_2/io1_i

ad_connect sys_cpu_clk axi_spi_2/ext_spi_clk

ad_cpu_interrupt ps-15 mb-7 axi_spi_2/ip2intc_irpt

ad_cpu_interconnect 0x44A80000 axi_spi_2

# Third SPI controller
create_bd_port -dir O -from 7 -to 0 spi_3_csn_o
create_bd_port -dir I -from 7 -to 0 spi_3_csn_i
create_bd_port -dir I spi_3_clk_i
create_bd_port -dir O spi_3_clk_o
create_bd_port -dir I spi_3_sdo_i
create_bd_port -dir O spi_3_sdo_o
create_bd_port -dir I spi_3_sdi_i

ad_ip_instance axi_quad_spi axi_spi_3
ad_ip_parameter axi_spi_3 CONFIG.C_USE_STARTUP 0
ad_ip_parameter axi_spi_3 CONFIG.C_NUM_SS_BITS 8
ad_ip_parameter axi_spi_3 CONFIG.C_SCK_RATIO 16
ad_ip_parameter axi_spi_3 CONFIG.Multiples16 16

ad_connect spi_3_csn_i axi_spi_3/ss_i
ad_connect spi_3_csn_o axi_spi_3/ss_o
ad_connect spi_3_clk_i axi_spi_3/sck_i
ad_connect spi_3_clk_o axi_spi_3/sck_o
ad_connect spi_3_sdo_i axi_spi_3/io0_i
ad_connect spi_3_sdo_o axi_spi_3/io0_o
ad_connect spi_3_sdi_i axi_spi_3/io1_i

ad_connect sys_cpu_clk axi_spi_3/ext_spi_clk

ad_cpu_interrupt ps-15 mb-6 axi_spi_3/ip2intc_irpt

ad_cpu_interconnect 0x44B80000 axi_spi_3