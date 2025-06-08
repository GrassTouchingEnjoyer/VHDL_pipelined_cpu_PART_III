----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:49:32 06/17/2024 
-- Design Name: 
-- Module Name:    FORWARD_UNIT - Behavioral 
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

entity FORWARD_UNIT is
	
	PORT(
	
		Clk : in  STD_LOGIC; 	  
		Rst : in  STD_LOGIC;	
		
		RS  : in  STD_LOGIC_VECTOR(5-1 DOWNTO 0);
		RT  : in  STD_LOGIC_VECTOR(5-1 DOWNTO 0);
		
		RF_Datasel : in  STD_LOGIC;
		ALU_BIN_sel  : in  STD_LOGIC;
		ALU_BIN_sel_new: in  STD_LOGIC ;  
		
		EX_MEM_Rd : in  STD_LOGIC_VECTOR(5-1 DOWNTO 0);
		MEM_WB_Rd : in  STD_LOGIC_VECTOR(5-1 DOWNTO 0);
		
		FORWARD_A : OUT  STD_LOGIC_VECTOR(2 DOWNTO 0);
		FORWARD_B : OUT  STD_LOGIC_VECTOR(3-1 DOWNTO 0)
		
		);		

end FORWARD_UNIT;

architecture Behavioral of FORWARD_UNIT is

-------------------------------|SIGNALS|-------------------------------
		
		signal   signal_FORWARD_out_A : STD_LOGIC_VECTOR(2 DOWNTO 0);
		
		signal   signal_FORWARD_out_B : STD_LOGIC_VECTOR(3-1 DOWNTO 0);
		
-----------------------------------------------------------------------



begin

	process (Clk,Rst,RS,RT,EX_MEM_Rd,MEM_WB_Rd) begin
	
	IF Rst = '1' THEN -- ( NOTHING )
		
		 signal_FORWARD_out_A <= "000";
		 signal_FORWARD_out_B <= "000";
	
	ELSE  
		 
		 signal_FORWARD_out_A <= "000";	
		 signal_FORWARD_out_B <= "000";							
--______________________________________________				
			
			IF (RS = EX_MEM_Rd) THEN	
			
				signal_FORWARD_out_A <= "001";

			ELSIF(RS = MEM_WB_Rd) THEN	

				IF (RF_Datasel = '0') THEN
				
					signal_FORWARD_out_A <= "100";
					
				ELSIF (RF_Datasel = '1') THEN
				
					signal_FORWARD_out_A <= "010";
				
				END IF;
				
			END IF;	
--______________________________________________						
					
					
					
					
					
--_____________________________________________________						
					
			IF ( ALU_BIN_sel_new = '1') THEN		
		
				signal_FORWARD_out_B <= "001"; --IMMED
			
			ELSIF( ALU_BIN_sel_new = '0') THEN
			
				IF (RT = EX_MEM_Rd) THEN	
						
					signal_FORWARD_out_B <= "010";
						
					ELSIF (RT = MEM_WB_Rd) THEN
				
						IF (RF_Datasel = '0') THEN
					
							signal_FORWARD_out_B <= "101";
						
						ELSIF (RF_Datasel = '1') THEN
					
							signal_FORWARD_out_B <= "100";
					
						END IF;
						
				 END IF;
				
			END IF;

			
--______________________________________________________							
		END IF;
		
		FORWARD_A <= signal_FORWARD_out_A;
		FORWARD_B <= signal_FORWARD_out_B;
		
	end process;
		
end Behavioral;

