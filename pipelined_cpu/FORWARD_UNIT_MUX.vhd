library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity FORWARD_UNIT_MUX is

	PORT(
	
		Clk :in  STD_LOGIC;
		Rst :in  STD_LOGIC;
		
		FORWARD_RFA_sel  :in  STD_LOGIC_VECTOR(2 downto 0);
		
		normal_flow_A    :in  STD_LOGIC_VECTOR(31 DOWNTO 0);
		EXEC_A 		     :in  STD_LOGIC_VECTOR(31 DOWNTO 0);
		MEM_ALU_A 		  :in  STD_LOGIC_VECTOR(31 DOWNTO 0);
		MEM_A 		  	  :in  STD_LOGIC_VECTOR(31 DOWNTO 0);

		FORWARD_MUX_DOUT :out  STD_LOGIC_VECTOR(31 DOWNTO 0)
		
	);

end FORWARD_UNIT_MUX;



architecture Behavioral of FORWARD_UNIT_MUX is

-------------------------------|SIGNALS|-----------------------------

	signal signal_FORWARD_MUX_DOUT : STD_LOGIC_VECTOR(31 DOWNTO 0);
			
---------------------------------------------------------------------
begin

process(Clk,Rst,normal_flow_A,MEM_A,EXEC_A,FORWARD_RFA_sel)begin

	IF RST= '1' THEN
		
		signal_FORWARD_MUX_DOUT <= "00000000000000000000000000000000";
	
	ELSE

		case FORWARD_RFA_sel is



--__________________________________________________________
			when "000" =>

				signal_FORWARD_MUX_DOUT <= normal_flow_A;

--__________________________________________________________





--__________________________________________________________
			when "001" =>

				signal_FORWARD_MUX_DOUT <= EXEC_A;	 
--__________________________________________________________				
				
				
				
--__________________________________________________________

			when "010" =>
				
				signal_FORWARD_MUX_DOUT <= MEM_ALU_A;
--__________________________________________________________





--__________________________________________________________			
			when "100" =>
			
				signal_FORWARD_MUX_DOUT <= MEM_A;
--__________________________________________________________			
			
			
			when others => ----nothing
	

		end case;
		
	END IF;
	
	FORWARD_MUX_DOUT <= signal_FORWARD_MUX_DOUT;
	
end process;
	
end Behavioral;