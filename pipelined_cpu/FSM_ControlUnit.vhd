----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:31:06 05/27/2024 
-- Design Name: 
-- Module Name:    FSM_ControlUnit - Behavioral 
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

entity FSM_ControlUnit is

PORT(

-------------------------|PART 1|------------------------------
			  
			  ean_branch : in  STD_LOGIC;
			  
			  PC_sel : out  STD_LOGIC;

           PC_LdEn : out  STD_LOGIC;

           RF_WrEn : out  STD_LOGIC;

           RF_WrData_sel : out  STD_LOGIC;

           RF_B_sel : out  STD_LOGIC;

           fill_mode_sel : out  STD_LOGIC;

           shift_en : out  STD_LOGIC;

           ALU_BIN_sel : out  STD_LOGIC;

           ALU_func : out  STD_LOGIC_VECTOR(3 DOWNTO 0);

           sel_16_immed : out  STD_LOGIC;

           li_sel : out  STD_LOGIC;

           MEM_WrEn : out  STD_LOGIC;

           sel_rfd_mask : out  STD_LOGIC;

           sel_mem_mask : out  STD_LOGIC;
	
-----------------------------|PART 2|------------------------------------
	
		Instr 							: in  STD_LOGIC_VECTOR (31 downto 0) ;
		RST   							: in  STD_LOGIC;
		Clk   							: in  STD_LOGIC;       
		IF_REG_DEC_enable   			: OUT STD_LOGIC;
		DEC_rfa_EXEC_enable 			: OUT STD_LOGIC;
		DEC_rfb_EXEC_enable 			: OUT STD_LOGIC;
		EXEC_REG_MEM_enable 			: OUT STD_LOGIC;
		WRITE_BACK_MEM_enable_DEC  : OUT STD_LOGIC
--------------------------------------------------------------------------

);

end FSM_ControlUnit;

architecture Behavioral of FSM_ControlUnit is

type State_type IS (IDLE, IF_STAGE, DEC_STAGE, EXEC_STAGE_R , WRITE_BACK_R, EXEC_STAGE_LI,EXEC_STAGE_LUI,EXEC_STAGE_ADDI,EXEC_STAGE_ANDI,EXEC_STAGE_ORI,EXEC_STAGE_B,EXEC_STAGE_LB,WRITE_BACK_MEM_LOAD,EXEC_STAGE_SB,WRITE_BACK_MEM_SAVE,EXEC_STAGE_LW,EXEC_STAGE_SW,EXEC_STAGE_BEQ,EXEC_STAGE_BNE); 

------------------------|SIGNALS|---------------------------

---------------------|SIGNALS PART 1|-----------------------

signal   signal_ALU_func	   : STD_LOGIC_VECTOR(3 downto 0);

-----------------------|SIGNALS PART 2|------------------------

		signal y      : State_type	;
		
		signal Opcode 		  : STD_LOGIC_VECTOR (5 downto 0);
		signal Func   		  : STD_LOGIC_VECTOR( 5 DOWNTO 0);
		
						--|REGISTER ENABLES|--
						
		signal IF_REG_DEC_enable_signal   			 : STD_LOGIC;
		signal DEC_rfa_EXEC_enable_signal			 : STD_LOGIC;
		signal DEC_rfb_EXEC_enable_signal 			 : STD_LOGIC;
		signal EXEC_REG_MEM_enable_signal 			 : STD_LOGIC;
		signal WRITE_BACK_MEM_enable_DEC_signal    : STD_LOGIC;
		
---------------------------------------------------------------


begin

	Opcode 		 	 <= Instr(31 downto 26 )    ;
	Func   		 	 <= Instr(5  downto 0  )    ;
	signal_ALU_func <= Instr(3  downto 0  )    ;

FSM_ControlUnit : PROCESS

begin

	Wait until (Clk'EVENT AND Clk = '1');  -- Clock

	IF RST = '1' THEN								-- Reset
	
		y <= IDLE ; 								-- Initial state
 
 
 ELSE
 
 case y is 											-- IF RESET = 0
 
 
 
------------------------------------------------------------------------------- 
	when IDLE =>
			  
			  PC_sel <= '0';

           PC_LdEn <= '0';

           RF_WrEn <= '0';

           RF_WrData_sel <= '0';

           RF_B_sel <= '0';

           fill_mode_sel <= '0';

           shift_en <= '0';

           ALU_BIN_sel <= '0';

           ALU_func <= "0000";

           sel_16_immed <= '0';

           li_sel <= '0';

           MEM_WrEn <= '0';

           sel_rfd_mask <= '0';

           sel_mem_mask <= '0';
			  
			  
			 IF_REG_DEC_enable <= '0';		  
			 DEC_rfa_EXEC_enable <= '0';		 
			 DEC_rfb_EXEC_enable <= '0';     		 
			 EXEC_REG_MEM_enable <= '0';  		 
			 WRITE_BACK_MEM_enable_DEC <= '0';
		
		y <= IF_STAGE;
-------------------------------------------------------------------------------		
		
		
		
		
		
-------------------------------------------------------------------------------	
	when IF_STAGE =>
	
		 RF_WrEn 		<= '0';			
		 RF_WrData_sel <= '0';	
		 --------------------
		 PC_sel 	<= '1'; 
		 PC_LdEn	<= '1';
		 --------------------
		 
		 fill_mode_sel <= '0'; 
		 shift_en      <= '0'; 		
		 sel_16_immed  <= '0';
		 MEM_WrEn 	   <= '0';
		 
		
	
		 IF_REG_DEC_enable   		  <= '1';
		 DEC_rfa_EXEC_enable		     <= '1';		 
		 DEC_rfb_EXEC_enable	        <= '1';		 
		 EXEC_REG_MEM_enable 		  <= '0';		 
		 WRITE_BACK_MEM_enable_DEC   <= '0';  
		
	
		y <= DEC_STAGE;
-------------------------------------------------------------------------------








	
-------------------------------------------------------------------------------	
	when DEC_STAGE =>
		
	-----------------------------------------
	 IF (Opcode = "100000") THEN
	 
		y <= EXEC_STAGE_R;
		
		RF_WrEn 		  <= '1';			
		RF_WrData_sel <= '1';
		----------------------
		PC_sel 	<= '0'; 
	   PC_LdEn	<= '0';
		---------------------- 
			IF_REG_DEC_enable   		   <= '0';
			DEC_rfa_EXEC_enable		   <= '1';		 
			DEC_rfb_EXEC_enable	      <= '1';		 
			EXEC_REG_MEM_enable 		   <= '0';		  
			WRITE_BACK_MEM_enable_DEC  <= '0';
	----------------------------------------- 
	ELSIF (Opcode = "111000") THEN	--LI 		
		
		RF_WrEn 		  <= '1';			
		RF_WrData_sel <= '1';
		y <= EXEC_STAGE_LI;	
		----------------------
		PC_sel 	     <= '0'; 
	   PC_LdEn	     <= '0';
		---------------------- 
		sel_16_immed  <= '0';
		fill_mode_sel <= '1'; 
		---------------------- 
		
			IF_REG_DEC_enable   		    <= '0';
			DEC_rfa_EXEC_enable		    <= '1';		 
			DEC_rfb_EXEC_enable	       <= '1';		 
			EXEC_REG_MEM_enable 		    <= '0';		  
			WRITE_BACK_MEM_enable_DEC   <= '0';
	-----------------------------------------
	ELSIF (Opcode = "111001") THEN	--LUI
				RF_WrEn 		  <= '1';			
				RF_WrData_sel <= '1';
		      y <= EXEC_STAGE_LUI;
				----------------------
				PC_sel 	<= '0'; 
				PC_LdEn	<= '0'; 
				----------------------
				fill_mode_sel  <= '0'; 
				sel_16_immed   <= '1'; 
				----------------------
			IF_REG_DEC_enable   		    <= '0';
			DEC_rfa_EXEC_enable		    <= '1';		 
			DEC_rfb_EXEC_enable	       <= '1';		 
			EXEC_REG_MEM_enable 		    <= '0';		  
			WRITE_BACK_MEM_enable_DEC   <= '0';
	------------------------------------------
		ELSIF (Opcode = "110000") THEN	--ADDI
				
				RF_WrEn 		  <= '1';			
				RF_WrData_sel <= '1';
		      y <= EXEC_STAGE_ADDI;
		
				----------------------
				PC_sel 	<= '0'; 
				PC_LdEn	<= '0'; 
				----------------------
				fill_mode_sel <= '1'; 
				sel_16_immed  <= '0';  
				----------------------
			IF_REG_DEC_enable   		    <= '0';
			DEC_rfa_EXEC_enable		    <= '1';		 
			DEC_rfb_EXEC_enable	       <= '1';		 
			EXEC_REG_MEM_enable 		    <= '0';		  
			WRITE_BACK_MEM_enable_DEC   <= '0';	
	------------------------------------------
		ELSIF (Opcode = "110010") THEN	--ANDI
		
				RF_WrEn 		  <= '1';			
				RF_WrData_sel <= '1';
		      y <= EXEC_STAGE_ANDI;
				----------------------
				PC_sel 	<= '0'; 
				PC_LdEn	<= '0'; 
				-----------------------
				fill_mode_sel   <= '1'; 
				sel_16_immed    <= '0'; 
				-----------------------
		IF_REG_DEC_enable   		    <= '0';
	   DEC_rfa_EXEC_enable		    <= '1';		 
	   DEC_rfb_EXEC_enable	       <= '1';		 
	   EXEC_REG_MEM_enable 		    <= '0';		  
	   WRITE_BACK_MEM_enable_DEC   <= '0';	

	-----------------------------------------
	   ELSIF (Opcode = "110011") THEN   --ORI
				
				RF_WrEn 		  <= '1';			
				RF_WrData_sel <= '1';
		      y <= EXEC_STAGE_ORI;
				----------------------
				PC_sel 	<= '0'; 
				PC_LdEn	<= '0'; 
				-----------------------
				fill_mode_sel <= '1'; 
				sel_16_immed  <= '0'; 
				-----------------------
		IF_REG_DEC_enable   		    <= '0';
	   DEC_rfa_EXEC_enable		    <= '1';		 
	   DEC_rfb_EXEC_enable	       <= '1';		 
	   EXEC_REG_MEM_enable 		    <= '0';		  
	   WRITE_BACK_MEM_enable_DEC   <= '0';	
	-----------------------------------------
	   ELSIF (Opcode = "000011") THEN    --LB
				
				RF_WrEn 		  <= '1';			
				RF_WrData_sel <= '1';
		      y <= EXEC_STAGE_LB;
				----------------------
				PC_sel 	<= '0'; 
				PC_LdEn	<= '0'; 
				----------------------- 
				fill_mode_sel  <= '1'; 
				shift_en       <= '0'; 
				sel_16_immed   <= '0'; 
				MEM_WrEn 	   <= '0';
				-----------------------
		IF_REG_DEC_enable   		    <= '0';
	   DEC_rfa_EXEC_enable		    <= '1';		 
	   DEC_rfb_EXEC_enable	       <= '1';		 
	   EXEC_REG_MEM_enable 		    <= '0';		  
	   WRITE_BACK_MEM_enable_DEC   <= '0';	

	-----------------------------------------
		ELSIF (Opcode = "000111") THEN    --SB
	
		      y <= EXEC_STAGE_SB;
				-----------------------
				PC_sel 	<= '0'; 
				PC_LdEn	<= '0'; 
				-----------------------   
				fill_mode_sel  <= '1'; 
				RF_WrEn        <= '1';
				sel_rfd_mask	<= '0'; 
				-----------------------
		IF_REG_DEC_enable   		    <= '0';
	   DEC_rfa_EXEC_enable		    <= '1';		 
	   DEC_rfb_EXEC_enable	       <= '1';		 
	   EXEC_REG_MEM_enable 		    <= '0';		  
	   WRITE_BACK_MEM_enable_DEC   <= '0';	
		
	-----------------------------------------
	   ELSIF (Opcode = "001111") THEN    --LW
				
				RF_WrEn 		  <= '1';			
				RF_WrData_sel <= '1';
		      y <= EXEC_STAGE_LW;
				----------------------
				PC_sel 	<= '0'; 
				PC_LdEn	<= '0'; 
				----------------------
				fill_mode_sel  <= '1'; 
				shift_en       <= '0'; 
				MEM_WrEn 	   <= '0';
				sel_mem_mask   <= '1'; 
				-----------------------
		IF_REG_DEC_enable   		    <= '0';
	   DEC_rfa_EXEC_enable		    <= '1';		 
	   DEC_rfb_EXEC_enable	       <= '1';		 
	   EXEC_REG_MEM_enable 		    <= '0';		  
	   WRITE_BACK_MEM_enable_DEC   <= '0';	

	-----------------------------------------
		ELSIF (Opcode = "011111") THEN    --SW
	
		      y <= EXEC_STAGE_SW;
				-----------------------
				PC_sel 	<= '0'; 
				PC_LdEn	<= '0'; 
				-----------------------
				fill_mode_sel  <= '1'; 
				RF_WrEn        <= '1';
				sel_rfd_mask	<= '1'; 
				-----------------------
		IF_REG_DEC_enable   		    <= '0';
	   DEC_rfa_EXEC_enable		    <= '1';		 
	   DEC_rfb_EXEC_enable	       <= '1';		 
	   EXEC_REG_MEM_enable 		    <= '0';		  
	   WRITE_BACK_MEM_enable_DEC   <= '0';	

	-----------------------------------------
		ELSIF (Opcode = "111111") THEN    --B
		
				RF_WrEn 		  <= '0';			
				RF_WrData_sel <= '0';
		      y <= EXEC_STAGE_B;
				-----------------------
				PC_sel 	<= '0'; 
				PC_LdEn  <= '1';
				-----------------------    
				fill_mode_sel <= '1'; 
				shift_en      <= '1'; 
				-----------------------		
	-----------------------------------------
		ELSIF (Opcode = "010000") THEN   --BEQ
				
				-----------------------
				RF_WrEn 		  <= '0';			
				RF_WrData_sel <= '0';
		      y <= EXEC_STAGE_BEQ;
				-----------------------
			-----------------------------------	
			IF_REG_DEC_enable   		   <= '0';
			DEC_rfa_EXEC_enable		   <= '1';		 
			DEC_rfb_EXEC_enable	      <= '1';		 
			EXEC_REG_MEM_enable 		   <= '0';		  
			WRITE_BACK_MEM_enable_DEC  <= '0';
			-----------------------------------
		----------------------------------------------------    
	
	END IF;	 

-------------------------------------------------------------------------------



-------------------------------------------------------------------------------
when EXEC_STAGE_BEQ =>

		-------------------------------  
		IF (ean_branch = '1') THEN

            PC_sel 			<= '0'; 

				PC_LdEn			<= '1';      

				fill_mode_sel  <= '1'; 

				shift_en       <= '1'; 

				MEM_WrEn 	   <= '0';
		
		ELSE 
			
				RF_WrEn  	  <= '0';
					
				PC_LdEn		  <= '1';
					
            PC_sel 		  <= '1';  	     

				MEM_WrEn 	  <= '0';
				
		END IF;				
		------------------------------			

				y <= IF_STAGE;
				
-------------------------------------------------------------------------------






-------------------------------------------------------------------------------
when EXEC_STAGE_B =>

				---------------------- 
				PC_sel 			<= '0'; 
				
				PC_LdEn			<= '0';      

				fill_mode_sel  <= '0'; 

				shift_en       <= '0'; 			
				----------------------			

				y <= IF_STAGE;
				
-------------------------------------------------------------------------------






-------------------------------------------------------------------------------
when EXEC_STAGE_SW =>
				
				
				RF_WrEn <= '0';
				RF_WrData_sel <= '0';
				--------------------------------
			   RF_B_sel 	<= '1';  
				
				ALU_BIN_sel <= '1';

				ALU_func	   <= "0000";

				li_sel   	<= '1'; 
				--------------------------------
				
				IF_REG_DEC_enable   	   	<= '0';
				DEC_rfa_EXEC_enable		   <= '1';		 
				DEC_rfb_EXEC_enable 	   	<= '1';		 
				EXEC_REG_MEM_enable			<= '1';		 
				WRITE_BACK_MEM_enable_DEC  <= '0'; 
			
				y <= WRITE_BACK_MEM_SAVE;
				
-------------------------------------------------------------------------------







-------------------------------------------------------------------------------
when EXEC_STAGE_LW =>
	
				--------------------------------
				ALU_BIN_sel   <= '1';

				ALU_func	     <= "0000";

				li_sel   	  <= '1'; 
				--------------------------------
				
				IF_REG_DEC_enable   	   	<= '0';
				DEC_rfa_EXEC_enable		   <= '0';		 
				DEC_rfb_EXEC_enable 	   	<= '0';		 
				EXEC_REG_MEM_enable			<= '0';		 
				WRITE_BACK_MEM_enable_DEC  <= '1'; 
			
				y <= WRITE_BACK_MEM_LOAD;
			
-------------------------------------------------------------------------------









-------------------------------------------------------------------------------
when EXEC_STAGE_SB =>
				
				
				RF_WrEn <= '0';
				RF_WrData_sel <= '0';
				--------------------------------
			   RF_B_sel 	<= '1';  
				
				ALU_BIN_sel <= '1';

				ALU_func	   <= "0000";

				li_sel   	<= '0'; 
				--------------------------------
				
				IF_REG_DEC_enable   	   	<= '0';
				DEC_rfa_EXEC_enable		   <= '1';		 
				DEC_rfb_EXEC_enable 	   	<= '1';		 
				EXEC_REG_MEM_enable			<= '1';		 
				WRITE_BACK_MEM_enable_DEC  <= '0'; 
			
				y <= WRITE_BACK_MEM_SAVE;
				
-------------------------------------------------------------------------------







-------------------------------------------------------------------------------
when EXEC_STAGE_LB =>
	
				--------------------------------
				ALU_BIN_sel    <= '1';
 
				ALU_func	      <= "0000";
				
				li_sel   	   <= '1'; 
				--------------------------------
				
				IF_REG_DEC_enable   	   	<= '0';
				DEC_rfa_EXEC_enable		   <= '0';		 
				DEC_rfb_EXEC_enable 	   	<= '0';		 
				EXEC_REG_MEM_enable			<= '0';		 
				WRITE_BACK_MEM_enable_DEC  <= '1'; 
			
				y <= WRITE_BACK_MEM_LOAD;
			
			
-------------------------------------------------------------------------------






-------------------------------------------------------------------------------
when EXEC_STAGE_ORI =>
	
				--------------------------------
				ALU_BIN_sel   <= '1';

				ALU_func	     <= "0011";
				
				li_sel   	  <= '1'; 
				--------------------------------
			
					
				IF_REG_DEC_enable   	   	<= '0';
				DEC_rfa_EXEC_enable		   <= '0';		 
				DEC_rfb_EXEC_enable 	   	<= '0';		 
				EXEC_REG_MEM_enable			<= '1';		 
				WRITE_BACK_MEM_enable_DEC  <= '0'; 
			
				y <= WRITE_BACK_R;
			
-------------------------------------------------------------------------------









-------------------------------------------------------------------------------
when EXEC_STAGE_ANDI =>
	
				--------------------------------
				ALU_BIN_sel   <= '1';

				ALU_func	   <= "0010";

				li_sel   	 	<= '1'; 
				--------------------------------
			
					
				IF_REG_DEC_enable   	   	<= '0';
				DEC_rfa_EXEC_enable		   <= '0';		 
				DEC_rfb_EXEC_enable 	   	<= '0';		 
				EXEC_REG_MEM_enable			<= '1';		 
				WRITE_BACK_MEM_enable_DEC  <= '0'; 
			
				y <= WRITE_BACK_R;
			
-------------------------------------------------------------------------------










-------------------------------------------------------------------------------
when EXEC_STAGE_ADDI =>
	
				--------------------------------
				ALU_BIN_sel    <= '1';

				ALU_func	      <= "0000";

				li_sel   	 	<= '0'; 
				--------------------------------
			
					
				IF_REG_DEC_enable   	   	<= '0';
				DEC_rfa_EXEC_enable		   <= '0';		 
				DEC_rfb_EXEC_enable 	   	<= '0';		 
				EXEC_REG_MEM_enable			<= '1';		 
				WRITE_BACK_MEM_enable_DEC  <= '0'; 
			
				y <= WRITE_BACK_R;
			
-------------------------------------------------------------------------------









-------------------------------------------------------------------------------
when EXEC_STAGE_LUI =>
	
				--------------------------------
				ALU_BIN_sel    <= '1';

				ALU_func	      <= "0000";

				li_sel   	 	<= '0'; 
				--------------------------------
			
					
				IF_REG_DEC_enable   	   	<= '0';
				DEC_rfa_EXEC_enable		   <= '0';		 
				DEC_rfb_EXEC_enable 	   	<= '0';		 
				EXEC_REG_MEM_enable			<= '1';		 
				WRITE_BACK_MEM_enable_DEC  <= '0'; 
			
				y <= WRITE_BACK_R;
			

-------------------------------------------------------------------------------








-------------------------------------------------------------------------------
when EXEC_STAGE_LI =>
	
				--------------------------------
				ALU_BIN_sel   <= '1';

				ALU_func	     <= "0000";

				li_sel   	  <= '0'; 
				--------------------------------
			
					
				IF_REG_DEC_enable   	   	<= '0';
				DEC_rfa_EXEC_enable		   <= '0';		 
				DEC_rfb_EXEC_enable 	   	<= '0';		 
				EXEC_REG_MEM_enable			<= '1';		 
				WRITE_BACK_MEM_enable_DEC  <= '0'; 
			
				y <= WRITE_BACK_R;
			

-------------------------------------------------------------------------------
			
	



	
-------------------------------------------------------------------------------
when EXEC_STAGE_R => 
	
	 
			--------------------------------
			ALU_BIN_sel   <= '0';
	
			ALU_func	     <= signal_ALU_func;

			li_sel   	  <= '1';
			--------------------------------
			
					
		   IF_REG_DEC_enable   	   	<= '0';
			DEC_rfa_EXEC_enable		   <= '0';		 
			DEC_rfb_EXEC_enable 	   	<= '0';		 
			EXEC_REG_MEM_enable			<= '1';		 
			WRITE_BACK_MEM_enable_DEC  <= '0'; 
			
			y <= WRITE_BACK_R;
			
-------------------------------------------------------------------------------








-------------------------------------------------------------------------------	
when WRITE_BACK_MEM_SAVE =>
			
			------------------------		
			RF_WrEn        <= '0'; 
			RF_WrData_sel  <= '0';
			MEM_WrEn 	   <= '1';
			------------------------

			IF_REG_DEC_enable   	      <= '0';
			DEC_rfa_EXEC_enable		   <= '0';		 
			DEC_rfb_EXEC_enable 	  	   <= '0';		 
			EXEC_REG_MEM_enable 		   <= '0';		 
			WRITE_BACK_MEM_enable_DEC  <= '1'; 

			y <= IF_STAGE;
-------------------------------------------------------------------------------	











-------------------------------------------------------------------------------	
when WRITE_BACK_MEM_LOAD =>
			
			ALU_BIN_sel    <= '0';
			li_sel   	   <= '0';
			shift_en       <= '0'; 
			sel_16_immed   <= '0'; 
			------------------------		
			RF_WrEn <= '1';
						
			RF_WrData_sel <= '1';
			------------------------

			IF_REG_DEC_enable   	      <= '0';
			DEC_rfa_EXEC_enable		   <= '0';		 
			DEC_rfb_EXEC_enable 	  	   <= '0';		 
			EXEC_REG_MEM_enable 		   <= '0';		 
			WRITE_BACK_MEM_enable_DEC  <= '1'; 

			y <= IF_STAGE;
-------------------------------------------------------------------------------	








-------------------------------------------------------------------------------	
when WRITE_BACK_R =>
			
			ALU_BIN_sel    <= '0';
			li_sel   	   <= '0';
			shift_en       <= '0'; 
			sel_16_immed   <= '0'; 
			------------------------					
			RF_WrData_sel <= '0';
			------------------------

			IF_REG_DEC_enable   	      <= '0';
			DEC_rfa_EXEC_enable		   <= '0';		 
			DEC_rfb_EXEC_enable 	  	   <= '0';		 
			EXEC_REG_MEM_enable 		   <= '0';		 
			WRITE_BACK_MEM_enable_DEC  <= '0'; 

			y <= IF_STAGE;
-------------------------------------------------------------------------------	
when others => y <= IDLE;


 end case;
 
 end if;
			  
			  
 END PROCESS ; 
			  


end Behavioral;
