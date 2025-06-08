----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:13:38 04/26/2024 
-- Design Name: 
-- Module Name:    Register_unit - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity WB_M_register_EX_MEM is

    Port ( Clk : in  STD_LOGIC;
           RST : in STD_LOGIC;
			  WE  : in  STD_LOGIC;
			  
           Data_in       : in  STD_LOGIC_VECTOR(31 downto 0); 
			  Data_rfb      : in STD_LOGIC_VECTOR (31 downto 0);
			  Data_Control  : in STD_LOGIC_VECTOR (4 downto 0);
			  Data_rd       : in STD_LOGIC_VECTOR (4 downto 0);
			  
           Dout_in 		: out  STD_LOGIC_VECTOR (31 downto 0);
			  Dout_rfb     : out STD_LOGIC_VECTOR   (31 downto 0);
			  Dout_Control : out  STD_LOGIC_VECTOR (4 downto 0);
			  Dout_rd 		: out  STD_LOGIC_VECTOR (4 downto 0));
			  
end WB_M_register_EX_MEM;

architecture Behavioral of WB_M_register_EX_MEM is

------------------------|SIGNALS|----------------------------
signal signal_Data_in 		: STD_LOGIC_VECTOR (31 downto 0);
signal signal_Data_rfb		: STD_LOGIC_VECTOR (31 downto 0);  
signal signal_Data_Control : STD_LOGIC_VECTOR (4 downto 0);
signal signal_Data_rd		: STD_LOGIC_VECTOR (4 downto 0);
-------------------------------------------------------------

begin

	process begin
		
		WAIT UNTIL Clk'EVENT AND Clk = '1' ;
		
			
			IF RST = '1' THEN
				
				signal_Data_in 	  <= "00000000000000000000000000000000";
				signal_Data_rfb	  <= "00000000000000000000000000000000";
				signal_Data_Control <= "00000";
				signal_Data_rd		  <= "00000";
         
			ELSE
				
				IF WE = '1' THEN
				
					signal_Data_in 	  <= Data_in;
					signal_Data_Control <= Data_Control;
					signal_Data_rd		  <= Data_rd;
					signal_Data_rfb     <= Data_rfb;
					
				ELSE
			
					signal_Data_in 	  <=	signal_Data_in;
					signal_Data_Control <=  signal_Data_Control;
					signal_Data_rd		  <=  signal_Data_rd;
					signal_Data_rfb     <=  signal_Data_rfb;
					
				END IF;
		 
			END IF;
		
	end process;	
	
	Dout_in 		 <=  signal_Data_in;
	Dout_Control <=  signal_Data_Control;
	Dout_rd 	    <=  signal_Data_rd;
	Dout_rfb     <=  signal_Data_rfb;
	
end Behavioral;