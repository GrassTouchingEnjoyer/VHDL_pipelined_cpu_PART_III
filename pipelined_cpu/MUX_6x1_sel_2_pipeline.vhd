----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:06:26 04/30/2024 
-- Design Name: 
-- Module Name:    MUX_2x1 - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MUX_6x1_sel_2_pipeline is

port(
	
	Clk : in STD_LOGIC ;
	Rst : in STD_LOGIC ;
	
	RF_B     	 : IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
	sl_16_out    : IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
	EXEC_B 		 : in  STD_LOGIC_VECTOR(31 DOWNTO 0);
	MEM_ALU_B 	 : in  STD_LOGIC_VECTOR(31 DOWNTO 0);
	MEM_B 		 : in  STD_LOGIC_VECTOR(31 DOWNTO 0);
	immed_or_rfb : IN  STD_LOGIC_VECTOR(2 DOWNTO 0);
	output		 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
);


end MUX_6x1_sel_2_pipeline;

architecture Behavioral of MUX_6x1_sel_2_pipeline is

signal output_signal: STD_LOGIC_VECTOR (31 DOWNTO 0);

begin

process(Clk,Rst,RF_B,sl_16_out,immed_or_rfb,EXEC_B,MEM_ALU_B,MEM_B) begin


IF(Rst = '1')THEN

	output_signal <= "00000000000000000000000000000000";

	ELSE
	
	output_signal <= RF_B;

		case (immed_or_rfb) is

--____________________________________________
			WHEN "000" =>
				
				output_signal <= RF_B;
--____________________________________________



				
--____________________________________________				
			WHEN	"001" =>
				
				output_signal <= sl_16_out;
--____________________________________________		

		
				
				
--____________________________________________				
			WHEN "010" =>
				
				output_signal <= EXEC_B;
--____________________________________________		


		
				
--____________________________________________		
			WHEN "100" => -- ALU
			
				output_signal <= MEM_ALU_B;
--____________________________________________				
				
				
				
				
--____________________________________________				
			WHEN "101" => -- MEM
			
				output_signal <= MEM_B;
--____________________________________________	
				
			when others =>
			
				--nothing
			
		END CASE;
		
	END IF;
	
end process;

output <= output_signal;

end Behavioral;