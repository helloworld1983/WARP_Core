
################################################################
# This is a generated script based on design: system
#
# Though there are limitations about the generated script,
# the main purpose of this utility is to make learning
# IP Integrator Tcl commands easier.
################################################################

namespace eval _tcl {
proc get_script_folder {} {
   set script_path [file normalize [info script]]
   set script_folder [file dirname $script_path]
   return $script_folder
}
}
variable script_folder
set script_folder [_tcl::get_script_folder]

################################################################
# START
################################################################

# To test this script, run the following commands from Vivado Tcl console:
# source system_script.tcl


# The design that will be created by this Tcl script contains the following 
# module references:
# LED_Control, RGB_Control, Reciever_Core, Top_Control, Transmitter_Core, local_memory, btn_control, btn_debounce, btn_debounce, btn_debounce, btn_debounce, btn_split

# Please add the sources of those modules before sourcing this Tcl script.

# If there is no project opened, this script will create a
# project, but make sure you do not have an existing project
# <./myproj/project_1.xpr> in the current working folder.

set list_projs [get_projects -quiet]
if { $list_projs eq "" } {
   create_project base base -part xc7a35ticsg324-1L
   set_property BOARD_PART digilentinc.com:arty:part0:1.1 [current_project]
}

add_files ../Src/hdl/

# CHANGE DESIGN NAME HERE
set design_name system

# If you do not already have an existing IP Integrator design open,
# you can create a design using the following command:
#    create_bd_design $design_name

# Creating design if needed
set errMsg ""
set nRet 0

set cur_design [current_bd_design -quiet]
set list_cells [get_bd_cells -quiet]

if { ${design_name} eq "" } {
   # USE CASES:
   #    1) Design_name not set

   set errMsg "Please set the variable <design_name> to a non-empty value."
   set nRet 1

} elseif { ${cur_design} ne "" && ${list_cells} eq "" } {
   # USE CASES:
   #    2): Current design opened AND is empty AND names same.
   #    3): Current design opened AND is empty AND names diff; design_name NOT in project.
   #    4): Current design opened AND is empty AND names diff; design_name exists in project.

   if { $cur_design ne $design_name } {
      common::send_msg_id "BD_TCL-001" "INFO" "Changing value of <design_name> from <$design_name> to <$cur_design> since current design is empty."
      set design_name [get_property NAME $cur_design]
   }
   common::send_msg_id "BD_TCL-002" "INFO" "Constructing design in IPI design <$cur_design>..."

} elseif { ${cur_design} ne "" && $list_cells ne "" && $cur_design eq $design_name } {
   # USE CASES:
   #    5) Current design opened AND has components AND same names.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 1
} elseif { [get_files -quiet ${design_name}.bd] ne "" } {
   # USE CASES: 
   #    6) Current opened design, has components, but diff names, design_name exists in project.
   #    7) No opened design, design_name exists in project.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 2

} else {
   # USE CASES:
   #    8) No opened design, design_name not in project.
   #    9) Current opened design, has components, but diff names, design_name not in project.

   common::send_msg_id "BD_TCL-003" "INFO" "Currently there is no design <$design_name> in project, so creating one..."

   create_bd_design $design_name

   common::send_msg_id "BD_TCL-004" "INFO" "Making design <$design_name> as current_bd_design."
   current_bd_design $design_name

}

common::send_msg_id "BD_TCL-005" "INFO" "Currently the variable <design_name> is equal to \"$design_name\"."

if { $nRet != 0 } {
   catch {common::send_msg_id "BD_TCL-114" "ERROR" $errMsg}
   return $nRet
}

##################################################################
# DESIGN PROCs
##################################################################


# Hierarchical cell: buttons
proc create_hier_cell_buttons { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_msg_id "BD_TCL-102" "ERROR" create_hier_cell_buttons() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_msg_id "BD_TCL-100" "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_msg_id "BD_TCL-101" "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins

  # Create pins
  create_bd_pin -dir I CLK100MHZ
  create_bd_pin -dir I -from 3 -to 0 btn_in
  create_bd_pin -dir O -from 3 -to 0 btn_out
  create_bd_pin -dir I rst_n

  # Create instance: btn_control_0, and set properties
  set block_name btn_control
  set block_cell_name btn_control_0
  if { [catch {set btn_control_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $btn_control_0 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: btn_debounce_0, and set properties
  set block_name btn_debounce
  set block_cell_name btn_debounce_0
  if { [catch {set btn_debounce_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $btn_debounce_0 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: btn_debounce_1, and set properties
  set block_name btn_debounce
  set block_cell_name btn_debounce_1
  if { [catch {set btn_debounce_1 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $btn_debounce_1 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: btn_debounce_2, and set properties
  set block_name btn_debounce
  set block_cell_name btn_debounce_2
  if { [catch {set btn_debounce_2 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $btn_debounce_2 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: btn_debounce_3, and set properties
  set block_name btn_debounce
  set block_cell_name btn_debounce_3
  if { [catch {set btn_debounce_3 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $btn_debounce_3 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: btn_split_0, and set properties
  set block_name btn_split
  set block_cell_name btn_split_0
  if { [catch {set btn_split_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $btn_split_0 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create port connections
  connect_bd_net -net CLK100MHZ_1 [get_bd_pins CLK100MHZ] [get_bd_pins btn_control_0/clk] [get_bd_pins btn_debounce_0/clk] [get_bd_pins btn_debounce_1/clk] [get_bd_pins btn_debounce_2/clk] [get_bd_pins btn_debounce_3/clk]
  connect_bd_net -net btn_control_0_btn_out [get_bd_pins btn_out] [get_bd_pins btn_control_0/btn_out]
  connect_bd_net -net btn_debounce_0_btn_out [get_bd_pins btn_control_0/btn_0] [get_bd_pins btn_debounce_0/btn_out]
  connect_bd_net -net btn_debounce_1_btn_out [get_bd_pins btn_control_0/btn_1] [get_bd_pins btn_debounce_1/btn_out]
  connect_bd_net -net btn_debounce_2_btn_out [get_bd_pins btn_control_0/btn_2] [get_bd_pins btn_debounce_2/btn_out]
  connect_bd_net -net btn_debounce_3_btn_out [get_bd_pins btn_control_0/btn_3] [get_bd_pins btn_debounce_3/btn_out]
  connect_bd_net -net btn_in_1 [get_bd_pins btn_in] [get_bd_pins btn_split_0/btn_in]
  connect_bd_net -net btn_split_0_btn0 [get_bd_pins btn_debounce_0/btn_in] [get_bd_pins btn_split_0/btn0]
  connect_bd_net -net btn_split_0_btn1 [get_bd_pins btn_debounce_1/btn_in] [get_bd_pins btn_split_0/btn1]
  connect_bd_net -net btn_split_0_btn2 [get_bd_pins btn_debounce_2/btn_in] [get_bd_pins btn_split_0/btn2]
  connect_bd_net -net btn_split_0_btn3 [get_bd_pins btn_debounce_3/btn_in] [get_bd_pins btn_split_0/btn3]
  connect_bd_net -net rst_n_1 [get_bd_pins rst_n] [get_bd_pins btn_control_0/rst_n] [get_bd_pins btn_debounce_0/rst_n] [get_bd_pins btn_debounce_1/rst_n] [get_bd_pins btn_debounce_2/rst_n] [get_bd_pins btn_debounce_3/rst_n]

  # Restore current instance
  current_bd_instance $oldCurInst
}


# Procedure to create entire design; Provide argument to make
# procedure reusable. If parentCell is "", will use root.
proc create_root_design { parentCell } {

  variable script_folder

  if { $parentCell eq "" } {
     set parentCell [get_bd_cells /]
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_msg_id "BD_TCL-100" "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_msg_id "BD_TCL-101" "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj


  # Create interface ports

  # Create ports
  set CLK100MHZ [ create_bd_port -dir I -type clk CLK100MHZ ]
  set_property -dict [ list \
CONFIG.FREQ_HZ {100000000} \
 ] $CLK100MHZ
  set btn [ create_bd_port -dir I -from 3 -to 0 btn ]
  set led [ create_bd_port -dir O -from 3 -to 0 led ]
  set rgb0 [ create_bd_port -dir O -from 2 -to 0 rgb0 ]
  set rgb1 [ create_bd_port -dir O -from 2 -to 0 rgb1 ]
  set rgb2 [ create_bd_port -dir O -from 2 -to 0 rgb2 ]
  set rgb3 [ create_bd_port -dir O -from 2 -to 0 rgb3 ]
  set rst_n [ create_bd_port -dir I -type rst rst_n ]
  set sw [ create_bd_port -dir I -from 3 -to 0 sw ]
  set uart_rx [ create_bd_port -dir I uart_rx ]
  set uart_tx [ create_bd_port -dir O uart_tx ]

  # Create instance: LED_Control_0, and set properties
  set block_name LED_Control
  set block_cell_name LED_Control_0
  if { [catch {set LED_Control_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $LED_Control_0 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: RGB_Control_0, and set properties
  set block_name RGB_Control
  set block_cell_name RGB_Control_0
  if { [catch {set RGB_Control_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $RGB_Control_0 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: Reciever_Core_0, and set properties
  set block_name Reciever_Core
  set block_cell_name Reciever_Core_0
  if { [catch {set Reciever_Core_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $Reciever_Core_0 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
    set_property -dict [ list \
CONFIG.BAUD_RATE {115200} \
 ] $Reciever_Core_0

  # Create instance: Top_Control_0, and set properties
  set block_name Top_Control
  set block_cell_name Top_Control_0
  if { [catch {set Top_Control_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $Top_Control_0 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: Transmitter_Core_0, and set properties
  set block_name Transmitter_Core
  set block_cell_name Transmitter_Core_0
  if { [catch {set Transmitter_Core_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $Transmitter_Core_0 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
    set_property -dict [ list \
CONFIG.BAUD_RATE {115200} \
 ] $Transmitter_Core_0

  # Create instance: buttons
  create_hier_cell_buttons [current_bd_instance .] buttons

  # Create instance: local_memory_0, and set properties
  set block_name local_memory
  set block_cell_name local_memory_0
  if { [catch {set local_memory_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $local_memory_0 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
    set_property -dict [ list \
CONFIG.ADDR_WIDTH {15} \
 ] $local_memory_0

  # Create port connections
  connect_bd_net -net CLK100MHZ_1 [get_bd_ports CLK100MHZ] [get_bd_pins LED_Control_0/clk] [get_bd_pins RGB_Control_0/CLK] [get_bd_pins Reciever_Core_0/clk] [get_bd_pins Top_Control_0/clk] [get_bd_pins Transmitter_Core_0/clk] [get_bd_pins buttons/CLK100MHZ] [get_bd_pins local_memory_0/clk]
  connect_bd_net -net LED_Control_0_led [get_bd_ports led] [get_bd_pins LED_Control_0/led]
  connect_bd_net -net RGB_Control_0_rgb0 [get_bd_ports rgb0] [get_bd_pins RGB_Control_0/rgb0]
  connect_bd_net -net RGB_Control_0_rgb1 [get_bd_ports rgb1] [get_bd_pins RGB_Control_0/rgb1]
  connect_bd_net -net RGB_Control_0_rgb2 [get_bd_ports rgb2] [get_bd_pins RGB_Control_0/rgb2]
  connect_bd_net -net RGB_Control_0_rgb3 [get_bd_ports rgb3] [get_bd_pins RGB_Control_0/rgb3]
  connect_bd_net -net RST_N_1 [get_bd_ports rst_n] [get_bd_pins LED_Control_0/rst_n] [get_bd_pins RGB_Control_0/RST_N] [get_bd_pins Reciever_Core_0/rst_n] [get_bd_pins Top_Control_0/rst_n] [get_bd_pins Transmitter_Core_0/rst_n] [get_bd_pins buttons/rst_n]
  connect_bd_net -net Reciever_Core_0_data_rx [get_bd_pins Reciever_Core_0/data_rx] [get_bd_pins Top_Control_0/data_rx]
  connect_bd_net -net Reciever_Core_0_rec_data [get_bd_pins Reciever_Core_0/rec_data] [get_bd_pins Top_Control_0/rec_data]
  connect_bd_net -net SW_1 [get_bd_ports sw] [get_bd_pins Top_Control_0/sw]
  connect_bd_net -net Top_Control_0_addr [get_bd_pins Top_Control_0/addr] [get_bd_pins local_memory_0/addr]
  connect_bd_net -net Top_Control_0_data_tx [get_bd_pins Top_Control_0/data_tx] [get_bd_pins Transmitter_Core_0/data_tx]
  connect_bd_net -net Top_Control_0_dout [get_bd_pins Top_Control_0/dout] [get_bd_pins local_memory_0/din]
  connect_bd_net -net Top_Control_0_led_en [get_bd_pins LED_Control_0/led_en] [get_bd_pins Top_Control_0/led_en]
  connect_bd_net -net Top_Control_0_led_input [get_bd_pins LED_Control_0/led_input] [get_bd_pins Top_Control_0/led_input]
  connect_bd_net -net Top_Control_0_rgb0_input [get_bd_pins RGB_Control_0/rgb0_input] [get_bd_pins Top_Control_0/rgb0_input]
  connect_bd_net -net Top_Control_0_rgb1_input [get_bd_pins RGB_Control_0/rgb1_input] [get_bd_pins Top_Control_0/rgb1_input]
  connect_bd_net -net Top_Control_0_rgb2_input [get_bd_pins RGB_Control_0/rgb2_input] [get_bd_pins Top_Control_0/rgb2_input]
  connect_bd_net -net Top_Control_0_rgb3_input [get_bd_pins RGB_Control_0/rgb3_input] [get_bd_pins Top_Control_0/rgb3_input]
  connect_bd_net -net Top_Control_0_rgb_en [get_bd_pins RGB_Control_0/rgb_en] [get_bd_pins Top_Control_0/rgb_en]
  connect_bd_net -net Top_Control_0_send_data [get_bd_pins Top_Control_0/send_data] [get_bd_pins Transmitter_Core_0/send_data]
  connect_bd_net -net Top_Control_0_we [get_bd_pins Top_Control_0/we] [get_bd_pins local_memory_0/we]
  connect_bd_net -net Transmitter_Core_0_tx [get_bd_ports uart_tx] [get_bd_pins Transmitter_Core_0/tx]
  connect_bd_net -net btn_1 [get_bd_ports btn] [get_bd_pins buttons/btn_in]
  connect_bd_net -net buttons_btn_out [get_bd_pins Top_Control_0/btn] [get_bd_pins buttons/btn_out]
  connect_bd_net -net local_memory_0_dout [get_bd_pins Top_Control_0/din] [get_bd_pins local_memory_0/dout]
  connect_bd_net -net uart_rx_1 [get_bd_ports uart_rx] [get_bd_pins Reciever_Core_0/rx]

  # Create address segments

  # Perform GUI Layout
  regenerate_bd_layout -layout_string {
   guistr: "# # String gsaved with Nlview 6.6.5b  2016-09-06 bk=1.3687 VDI=39 GEI=35 GUI=JA:1.6
#  -string -flagsOSRD
preplace port uart_tx -pg 1 -y 400 -defaultsOSRD
preplace port CLK100MHZ -pg 1 -y 380 -defaultsOSRD
preplace port uart_rx -pg 1 -y 470 -defaultsOSRD
preplace port rst_n -pg 1 -y 400 -defaultsOSRD
preplace portBus sw -pg 1 -y 190 -defaultsOSRD
preplace portBus btn -pg 1 -y 110 -defaultsOSRD
preplace portBus rgb0 -pg 1 -y 70 -defaultsOSRD
preplace portBus led -pg 1 -y 270 -defaultsOSRD
preplace portBus rgb1 -pg 1 -y 90 -defaultsOSRD
preplace portBus rgb2 -pg 1 -y 110 -defaultsOSRD
preplace portBus rgb3 -pg 1 -y 130 -defaultsOSRD
preplace inst buttons -pg 1 -lvl 1 -y 110 -defaultsOSRD
preplace inst Top_Control_0 -pg 1 -lvl 2 -y 180 -defaultsOSRD
preplace inst LED_Control_0 -pg 1 -lvl 3 -y 270 -defaultsOSRD
preplace inst Reciever_Core_0 -pg 1 -lvl 1 -y 410 -defaultsOSRD
preplace inst local_memory_0 -pg 1 -lvl 3 -y -150 -defaultsOSRD
preplace inst Transmitter_Core_0 -pg 1 -lvl 3 -y 410 -defaultsOSRD
preplace inst RGB_Control_0 -pg 1 -lvl 3 -y 100 -defaultsOSRD
preplace netloc btn_1 1 0 1 NJ
preplace netloc Top_Control_0_led_input 1 2 1 780
preplace netloc RST_N_1 1 0 3 -50 20 250 20 820
preplace netloc buttons_btn_out 1 1 1 240
preplace netloc Top_Control_0_rgb3_input 1 2 1 870
preplace netloc Top_Control_0_rgb2_input 1 2 1 860
preplace netloc Reciever_Core_0_data_rx 1 1 1 260
preplace netloc Top_Control_0_dout 1 2 1 780
preplace netloc Top_Control_0_send_data 1 2 1 790
preplace netloc Top_Control_0_rgb1_input 1 2 1 850
preplace netloc RGB_Control_0_rgb0 1 3 1 NJ
preplace netloc Transmitter_Core_0_tx 1 3 1 NJ
preplace netloc RGB_Control_0_rgb1 1 3 1 NJ
preplace netloc Top_Control_0_we 1 2 1 750
preplace netloc Reciever_Core_0_rec_data 1 1 1 250
preplace netloc Top_Control_0_rgb0_input 1 2 1 830
preplace netloc RGB_Control_0_rgb2 1 3 1 NJ
preplace netloc local_memory_0_dout 1 1 3 270 -70 NJ -70 1130
preplace netloc Top_Control_0_led_en 1 2 1 810
preplace netloc RGB_Control_0_rgb3 1 3 1 NJ
preplace netloc Top_Control_0_addr 1 2 1 760
preplace netloc Top_Control_0_data_tx 1 2 1 770
preplace netloc Top_Control_0_rgb_en 1 2 1 800
preplace netloc CLK100MHZ_1 1 0 3 -60 -180 260 -180 840
preplace netloc uart_rx_1 1 0 1 -60
preplace netloc LED_Control_0_led 1 3 1 NJ
preplace netloc SW_1 1 0 2 -70J 180 NJ
levelinfo -pg 1 -90 130 620 1000 1150 -top -220 -bot 910
",
}

  # Restore current instance
  current_bd_instance $oldCurInst

  save_bd_design
}
# End of create_root_design()


##################################################################
# MAIN FLOW
##################################################################

create_root_design ""

# Additional steps to get to bitstream
# generate toplevel wrapper files
set_property target_language VHDL [current_project]
make_wrapper -files [get_files ./base/base.srcs/sources_1/bd/system/system.bd] -top
add_files -norecurse ./base/base.srcs/sources_1/bd/system/hdl/system_wrapper.vhd
update_compile_order -fileset sources_1
update_compile_order -fileset sim_1

add_files -fileset constrs_1 -norecurse ../Src/const/Arty_Master.xdc
