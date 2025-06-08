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

entity WB_register_MEM_WB is

    Port ( Clk	    		: in  STD_LOGIC;
           RST 	 		: in STD_LOGIC;
			  WE 		 		: in  STD_LOGIC;
			  
			  Data_MEM 		: in  STD_LOGIC_VECTOR(31 DOWNTO 0);
			  Data_ALU 		: in  STD_LOGIC_VECTOR(31 DOWNTO 0);
			  Data_RD 		: in  STD_LOGIC_VECTOR(4 DOWNTO 0);
			  Data_CONTROL : in  STD_LOGIC_VECTOR(1 DOWNTO 0);
			  
			  Dout_MEM 		: out  STD_LOGIC_VECTOR(31 DOWNTO 0);
			  Dout_ALU 		: out  STD_LOGIC_VECTOR(31 DOWNTO 0);
			  Dout_RD 		: out  STD_LOGIC_VECTOR(4 DOWNTO 0);
			  Dout_CONTROL : out  STD_LOGIC_VECTOR(1 DOWNTO 0));
			  
end WB_register_MEM_WB;

architecture Behavioral of WB_register_MEM_WB is

---------------------------|SIGNALS|---------------------------
signal signal_Data_MEM		  : STD_LOGIC_VECTOR (31 downto 0);
signal signal_Data_ALU		  : STD_LOGIC_VECTOR (31 downto 0);
signal signal_Data_RD		  : STD_LOGIC_VECTOR (5-1 downto 0);
signal signal_Data_CONTROL   : STD_LOGIC_VECTOR (2-1 downto 0);
---------------------------------------------------------------

begin

	process begin
		
		WAIT UNTIL Clk'EVENT AND Clk = '1' ;
		
			
			IF RST = '1' THEN
				
				signal_Data_MEM 	  <= "00000000000000000000000000000000";
				signal_Data_ALU 	  <= "00000000000000000000000000000000";
				signal_Data_RD 	  <= "00000"; 
				signal_Data_CONTROL <= "00";
         
			ELSE
				
				IF WE = '1' THEN
				
					signal_Data_MEM 	  <= Data_MEM;
					signal_Data_ALU     <= Data_ALU;
					signal_Data_RD 	  <= Data_RD;
					signal_Data_CONTROL <= Data_CONTROL;
					
					
				ELSE
			
					signal_Data_MEM 	  <= signal_Data_MEM;
					signal_Data_ALU     <= signal_Data_ALU;
					signal_Data_RD 	  <= signal_Data_RD;
					signal_Data_CONTROL <= signal_Data_CONTROL;	
					
				END IF;
		 
			END IF;
		
	end process;	
	
	Dout_MEM <= signal_Data_MEM;
	Dout_ALU <= signal_Data_ALU;
	Dout_RD <= signal_Data_RD;
	Dout_CONTROL <= signal_Data_CONTROL ;
	
end Behavioral;