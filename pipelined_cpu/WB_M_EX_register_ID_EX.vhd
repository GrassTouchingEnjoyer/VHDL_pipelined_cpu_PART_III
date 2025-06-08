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

entity WB_M_EX_register_ID_EX is

    Port ( Clk : in  STD_LOGIC;
           RST : in STD_LOGIC;
			  WE : in  STD_LOGIC;
			  
           Data_RFA : in  STD_LOGIC_VECTOR  (32-1 downto 0);	
			  Data_RFB : in  STD_LOGIC_VECTOR  (32-1 downto 0);	
			  Data_IMMED : in  STD_LOGIC_VECTOR  (32-1 downto 0);	
			  Data_CONTROL : in  STD_LOGIC_VECTOR  (12-1 downto 0);			  
           Data_RD : in  STD_LOGIC_VECTOR (5-1 downto 0);
			  
			  Dout_RFA : OUT  STD_LOGIC_VECTOR (32-1 downto 0);
			  Dout_RFB : OUT  STD_LOGIC_VECTOR  (32-1 downto 0);	
			  Dout_IMMED : OUT  STD_LOGIC_VECTOR  (32-1 downto 0);	
			  Dout_CONTROL : OUT  STD_LOGIC_VECTOR  (12-1 downto 0);		  
           Dout_RD : OUT  STD_LOGIC_VECTOR (5-1 downto 0));
			  
end WB_M_EX_register_ID_EX;

architecture Behavioral of WB_M_EX_register_ID_EX is

----------------|SIGNALS|------------------------------------
signal signal_Data_RFA  :	  STD_LOGIC_VECTOR  (32-1 downto 0);	
signal signal_Data_RFB   :	  STD_LOGIC_VECTOR  (32-1 downto 0);	
signal signal_Data_IMMED   :  STD_LOGIC_VECTOR (32-1 downto 0);	
signal signal_Data_CONTROL : STD_LOGIC_VECTOR  (12-1 downto 0);			  
signal signal_Data_RD  	:	  STD_LOGIC_VECTOR  (5-1  downto 0);
--------------------------------------------------------------

begin

	process begin
		
		WAIT UNTIL Clk'EVENT AND Clk = '1' ;
		
			
			IF RST = '1' THEN
				
				signal_Data_RFA     <= "00000000000000000000000000000000"; 
				signal_Data_RFB     <= "00000000000000000000000000000000"; 
				signal_Data_IMMED   <= "00000000000000000000000000000000"; 
				signal_Data_CONTROL <= "000000000000"; 
				signal_Data_RD      <= "00000";  

			ELSE
				
				IF WE = '1' THEN
				
					signal_Data_RFA <= Data_RFA; 
					signal_Data_RFB <=  Data_RFB; 
					signal_Data_IMMED <= Data_IMMED; 
					signal_Data_CONTROL <= Data_CONTROL; 
					signal_Data_RD <= Data_RD;  
					
				ELSE
			
					signal_Data_RFA <= signal_Data_RFA; 
					signal_Data_RFB <= signal_Data_RFB; 
					signal_Data_IMMED <= signal_Data_IMMED; 
					signal_Data_CONTROL <= signal_Data_CONTROL; 
					signal_Data_RD <= signal_Data_RD ;  	
					
				END IF;
		 
			END IF;
		
	end process;	
	
	Dout_RFA <= signal_Data_RFA;
	Dout_RFB <= signal_Data_RFB;
	Dout_IMMED <= signal_Data_IMMED;
	Dout_CONTROL <= signal_Data_CONTROL;		  
   Dout_RD <= signal_Data_RD;
	
end Behavioral;