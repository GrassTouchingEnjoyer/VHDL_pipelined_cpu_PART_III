----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:23:19 05/04/2024 
-- Design Name: 
-- Module Name:    DATAPATH_FINAL - Behavioral 
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

entity DATAPATH_FINAL is

Port(

Clk	    : in  STD_LOGIC;
Reset		 : in  STD_LOGIC
);


end DATAPATH_FINAL;

architecture Behavioral of DATAPATH_FINAL is

----------------------------|NEW PART 1|-----------------------------

signal alu_out_signal : STD_LOGIC_VECTOR(32-1 DOWNTO 0);
signal mem_out_signal : STD_LOGIC_VECTOR(32-1 DOWNTO 0);
signal immed_signal   : STD_LOGIC_VECTOR(32-1 DOWNTO 0);
signal rfa_signal     : STD_LOGIC_VECTOR(32-1 DOWNTO 0);
signal rfb_signal     : STD_LOGIC_VECTOR(32-1 DOWNTO 0);
signal instr_signal   : STD_LOGIC_VECTOR(32-1 DOWNTO 0);


------------------------------|NEW PART 2|-----------------------------


signal IF_REG_DEC_signal     		  : STD_LOGIC_VECTOR(32-1 DOWNTO 0);
signal DEC_rfa_EXEC_signal   		  : STD_LOGIC_VECTOR(32-1 DOWNTO 0);
signal DEC_rfb_EXEC_signal   		  : STD_LOGIC_VECTOR(32-1 DOWNTO 0);
signal EXEC_REG_MEM_signal	  		  : STD_LOGIC_VECTOR(32-1 DOWNTO 0);
signal WRITE_BACK_MEM_DEC_signal	  : STD_LOGIC_VECTOR(32-1 DOWNTO 0);

signal IF_REG_DEC_enable_signal 			 :STD_LOGIC;
signal DEC_rfa_EXEC_enable_signal 		 :STD_LOGIC;
signal DEC_rfb_EXEC_enable_signal		 :STD_LOGIC;
signal EXEC_REG_MEM_enable_signal 		 :STD_LOGIC;
signal WRITE_BACK_MEM_enable_DEC_signal :STD_LOGIC;


------------------------------|NEW PART 3|--------------------------------

signal signal_Data_RD_1  : STD_LOGIC_VECTOR(5-1 DOWNTO 0); -- WR-M-EX
signal signal_Data_RD_2  : STD_LOGIC_VECTOR(5-1 DOWNTO 0); -- WR-M
signal signal_Data_RD_3  : STD_LOGIC_VECTOR(5-1 DOWNTO 0); -- WR

signal signal_Dout_RFA 		: STD_LOGIC_VECTOR  (32-1 downto 0);
signal signal_Dout_RFB_1 	: STD_LOGIC_VECTOR  (32-1 downto 0);	
signal signal_Dout_RFB_2   : STD_LOGIC_VECTOR  (32-1 downto 0);
signal signal_Dout_IMMED 	: STD_LOGIC_VECTOR  (32-1 downto 0);	
signal signal_Dout_CONTROL_12 : STD_LOGIC_VECTOR  (12-1 downto 0);		  
signal signal_Dout_RD 		: STD_LOGIC_VECTOR  (5-1 downto 0);

signal signal_Dout_in : STD_LOGIC_VECTOR  (32-1 downto 0);
signal signal_Dout_CONTROL_5 : STD_LOGIC_VECTOR  (5-1 downto 0);
signal signal_Dout_CONTROL_2 : STD_LOGIC_VECTOR  (2-1 downto 0);
signal signal_Dout_rd_1 : STD_LOGIC_VECTOR  (5-1 downto 0);
signal signal_Dout_rd_2 : STD_LOGIC_VECTOR  (5-1 downto 0);


signal	signal_Dout_MEM_WB : STD_LOGIC_VECTOR  (32-1 downto 0);    
signal   signal_Dout_ALU_WB : STD_LOGIC_VECTOR  (32-1 downto 0);
signal	signal_Dout_RD_WB  : STD_LOGIC_VECTOR  (5-1 downto 0);  
signal	signal_Dout_CONTROL_WB : STD_LOGIC_VECTOR  (2-1 downto 0);

-------------------------------------------------------------------

-----------------------------|NEW PART 3.5|------------------------------

signal	signal_FORWARD_A		  : STD_LOGIC_VECTOR  (2 downto 0);  
signal	signal_FORWARD_B 		  : STD_LOGIC_VECTOR  (2 downto 0);
signal   signal_ALU_RFA_MUX_out : STD_LOGIC_VECTOR  (32-1 downto 0);

-------------------------------| FORWARD |-------------------------------


signal	signal_PC_sel  	           : STD_LOGIC;
signal   signal_PC_LdEn		           : STD_LOGIC;
signal   signal_RF_WrEn               : STD_LOGIC;
signal   signal_RF_WrData_sel         : STD_LOGIC;
signal   signal_RF_B_sel              : STD_LOGIC;
signal   signal_fill_mode_sel 		  : STD_LOGIC;
signal   signal_shift_en      		  : STD_LOGIC;
signal   signal_ALU_BIN_sel   		  : STD_LOGIC;
signal   signal_ALU_func	   		  : STD_LOGIC_VECTOR(3 downto 0);
signal   signal_sel_16_immed  		  : STD_LOGIC;
signal   signal_li_sel   	   		  : STD_LOGIC;
signal   signal_MEM_WrEn 	   		  : STD_LOGIC;
signal   signal_sel_rfd_mask  		  : STD_LOGIC;
signal   signal_sel_mem_mask  		  : STD_LOGIC;

-------------------------------------------------

--------------------------------------------------------------------------












----------------------------------------------------------------
component CONTROLPATH_FINAL is

    Port ( 
			  
			  Clk  : in  STD_LOGIC;
			   	
			  Instr : in  STD_LOGIC_VECTOR (31 downto 0);
			  
			  Rst  : in  STD_LOGIC;

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

           sel_mem_mask : out  STD_LOGIC);

end component;
----------------------------------------------------------------





-------------------------|FORWARD UNIT|-------------------------
component FORWARD_UNIT is

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
		
end component;
----------------------------------------------------------------

---------------------------|MUX RFA|----------------------------


component FORWARD_UNIT_MUX is

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

end component;

----------------------------------------------------------------






------------------------------------------------------
component IFSTAGE

Port(
		PC_Immed: IN  STD_LOGIC_VECTOR (31 DOWNTO 0);
		PC_sel  : IN  STD_LOGIC;
		PC_LdEn : IN  STD_LOGIC;
		RST     : IN  STD_LOGIC;
		CLK     : IN  STD_LOGIC;
		Instr   : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)

);


end component;
------------------------------------------------------





---------------------------------------------------------
component DECSTAGE

Port(


		Instr         : in STD_LOGIC_VECTOR(31 DOWNTO 0) ;
		RF_WrEn       : in STD_LOGIC                     ;
		ALU_out       : in STD_LOGIC_VECTOR(31 DOWNTO 0) ;
		MEM_out       : in STD_LOGIC_VECTOR(31 DOWNTO 0) ;
		AWR_ADRESS	  : in STD_LOGIC_VECTOR (4 DOWNTO 0) ;
		RF_WrData_sel : in STD_LOGIC                     ;
		RF_B_sel		  : in STD_LOGIC					       ;
		Clk			  : in STD_LOGIC						    ;
		Reset			  : in STD_LOGIC						    ;
		fill_mode_sel : in STD_LOGIC                     ; -- fill_mode_sel and shift_en
		shift_en      : in STD_LOGIC                     ; -- will be control signals later on
		Immed			  : out STD_LOGIC_VECTOR(31 DOWNTO 0);
		RF_A			  : out STD_LOGIC_VECTOR(31 DOWNTO 0);
		RF_B		     : out STD_LOGIC_VECTOR(31 DOWNTO 0)                 
);

end component;
---------------------------------------------------|
-----------------|CONTROL REGISTER|----------------|
---------------------------------------------------|
component WB_M_EX_register_ID_EX

Port(

   Clk : in  STD_LOGIC;
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
   Dout_RD : OUT  STD_LOGIC_VECTOR (5-1 downto 0)
	
);

end component;
----------------------------------------------------------








-------------------------------------------------------------
component EXECSTAGE

PORT(

	Clk : in STD_LOGIC ;
   RST : in STD_LOGIC ;

	RF_A         : in  STD_LOGIC_VECTOR(32-1 DOWNTO 0 ) ;
	RF_B         : in  STD_LOGIC_VECTOR(32-1 DOWNTO 0 ) ;
	Immed        : in  STD_LOGIC_VECTOR(32-1 DOWNTO 0 ) ;
	sel_16_immed : in STD_LOGIC                         ;
	li_sel       : in STD_LOGIC                         ;
	ALU_BIN_sel  : in  STD_LOGIC                        ;
	Forward_control_sel : in  STD_LOGIC_VECTOR(2  DOWNTO 0 ) ;
	EXEC_B_IN 		     :in  STD_LOGIC_VECTOR(31 DOWNTO 0);
	MEM_ALU_B_IN  		  :in  STD_LOGIC_VECTOR(31 DOWNTO 0);
	MEM_B_IN  		  	  :in  STD_LOGIC_VECTOR(31 DOWNTO 0);
	ALU_func     : in  STD_LOGIC_VECTOR(4-1  DOWNTO 0 ) ;
	ALU_out 	    : out STD_LOGIC_VECTOR(32-1 DOWNTO 0 )
);


end component;
---------------------------------------------------|
-----------------|CONTROL REGISTER|----------------|
---------------------------------------------------|
component WB_M_register_EX_MEM 

    Port ( 
			  Clk : in  STD_LOGIC;
           RST : in STD_LOGIC;
			  WE  : in  STD_LOGIC;
			  
           Data_in       : in  STD_LOGIC_VECTOR(31 downto 0); 
			  Data_rfb      : in STD_LOGIC_VECTOR (31 downto 0);
			  Data_Control  : in STD_LOGIC_VECTOR (4 downto 0);
			  Data_rd       : in STD_LOGIC_VECTOR (4 downto 0);
			  
           Dout_in 		: out  STD_LOGIC_VECTOR (31 downto 0);
			  Dout_rfb     : out STD_LOGIC_VECTOR  (31 downto 0);
			  Dout_Control : out  STD_LOGIC_VECTOR (4 downto 0);
			  Dout_rd 		: out  STD_LOGIC_VECTOR (4 downto 0)
);


end component;
---------------------------------------------------------------






-------------------------------------------------------------
component MEMSTAGE

Port (

    a            : IN  STD_LOGIC_VECTOR(32-1  DOWNTO 0  ) ;
    d            : IN  STD_LOGIC_VECTOR(32-1  DOWNTO 0  ) ;
	 sel_rfd_mask : IN  STD_LOGIC                          ;
	 sel_mem_mask : IN  STD_LOGIC                          ;
    clk          : IN  STD_LOGIC							       ;
    we           : IN  STD_LOGIC								    ;
    spo 			  : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
  );

end component;
---------------------------------------------------|
-----------------|CONTROL REGISTER|----------------|
---------------------------------------------------|
component WB_register_MEM_WB
	
	    Port 
		 ( 
			  Clk	    		: in  STD_LOGIC;
           RST 	 		: in STD_LOGIC;
			  WE 		 		: in  STD_LOGIC;
			  
			  Data_MEM 		: in  STD_LOGIC_VECTOR(31 DOWNTO 0);
			  Data_ALU 		: in  STD_LOGIC_VECTOR(31 DOWNTO 0);
			  Data_RD 		: in  STD_LOGIC_VECTOR(4 DOWNTO 0);
			  Data_CONTROL : in  STD_LOGIC_VECTOR(1 DOWNTO 0);
			  
			  Dout_MEM 		: out  STD_LOGIC_VECTOR(31 DOWNTO 0);
			  Dout_ALU 		: out  STD_LOGIC_VECTOR(31 DOWNTO 0);
			  Dout_RD 		: out  STD_LOGIC_VECTOR(4 DOWNTO 0);
			  Dout_CONTROL : out  STD_LOGIC_VECTOR(1 DOWNTO 0)
		 );
			  


end component;
---------------------------------------------------------------





-----------------------------------------------------
component Register_unit

Port  ( 
			Clk : in  STD_LOGIC;
         RST : in STD_LOGIC;
			WE : in  STD_LOGIC;
         Data : in  STD_LOGIC_VECTOR (31 downto 0);
         Dout : out  STD_LOGIC_VECTOR (31 downto 0)
			  
		 );
			  
end component;
-----------------------------------------------------




begin




--__________________________________________________________
control_unit: CONTROLPATH_FINAL 

    PORT MAP( 
					
				Clk => Clk,
				
				Instr => instr_signal ,
			  
				Rst => Reset, 

				PC_sel => signal_PC_sel ,

				PC_LdEn => signal_PC_LdEn , 

				RF_WrEn => signal_RF_WrEn ,--

				RF_WrData_sel => signal_RF_WrData_sel ,--

				RF_B_sel => signal_RF_B_sel ,

				fill_mode_sel => signal_fill_mode_sel ,

				shift_en => signal_shift_en ,

				ALU_BIN_sel => signal_ALU_BIN_sel ,--

				ALU_func => signal_ALU_func ,--

				sel_16_immed => signal_sel_16_immed ,--

				li_sel => signal_li_sel ,--

				MEM_WrEn => signal_MEM_WrEn ,--

				sel_rfd_mask => signal_sel_rfd_mask ,--

				sel_mem_mask => signal_sel_mem_mask 
				);
--______________________________________________________________
--________________________|FORWARD UNIT|________________________
FORWARD_control_unit : FORWARD_UNIT

	PORT MAP(
	
		Clk => Clk,
		Rst => Reset,
		
		RS => instr_signal(25 DOWNTO 21),
		RT => instr_signal(15 DOWNTO 11),
		
		RF_Datasel =>  signal_Dout_CONTROL_5(3),	-- for rs
		ALU_BIN_sel	=>	signal_Dout_CONTROL_12(2), -- for immed or rt
		ALU_BIN_sel_new => signal_ALU_Bin_sel,
		
		EX_MEM_Rd  => signal_Dout_RD_2,
		MEM_WB_Rd  => signal_Dout_RD_WB,
		
		FORWARD_A  => signal_FORWARD_A,  		-- MUX_FOR_RFA:  FORWARD_UNIT_MUX	
		FORWARD_B  => signal_FORWARD_B	
		
		);	
--________________________________________________________________
--______________________________MUX_1_____________________________

MUX_FOR_RFA:  FORWARD_UNIT_MUX

	PORT MAP(
	
		Rst => Reset,
		Clk => Clk,

		FORWARD_RFA_sel  =>  signal_FORWARD_A,
		
		normal_flow_A    =>  signal_Dout_RFA,
		EXEC_A			  => 	signal_Dout_in,
		MEM_ALU_A		  => 	signal_Dout_ALU_WB,
		MEM_A				  => 	signal_Dout_MEM_WB,	  	 

		FORWARD_MUX_DOUT =>  signal_ALU_RFA_MUX_out

		);	



--________________________________________

fetch: IFSTAGE

PORT MAP(

			PC_Immed => immed_signal        ,		
			PC_sel   => '1'      			  ,
			PC_LdEn  => '1'			        ,
			RST      => Reset               ,
			CLK      => Clk                 ,
			Instr    => instr_signal		  
		);
		
--_______________|REGISTER|________________

if_dec: Register_unit

	PORT MAP
	(
		Clk => Clk											  ,
      RST => Reset										  ,
		WE => '1'                     			     ,
      Data => instr_signal								  ,
      Dout => IF_REG_DEC_signal						   
	);
--________________________________________

-----------------------------------------------|RD instr signal|
signal_Data_RD_1 <= instr_signal(20 downto 16);
-----------------------------------------------









--______________________________________________________________________

decode: DECSTAGE

PORT MAP(

		Instr         =>  instr_signal	   		  ,   --instr_signal
		RF_WrEn       =>  signal_Dout_CONTROL_WB(0) ,
		ALU_out       =>  signal_Dout_ALU_WB		  , 	        --signal--
		MEM_out       =>  signal_Dout_MEM_WB		  ,          --signal--
		AWR_ADRESS    =>  signal_Dout_RD_WB	        ,
		RF_WrData_sel =>  signal_Dout_CONTROL_WB(1) ,
		RF_B_sel		  => signal_RF_B_sel      		  ,
		Clk			  => Clk           		  		  ,
		Reset			  => Reset	      		  		  ,
		fill_mode_sel => signal_fill_mode_sel 		  ,
		shift_en      => signal_shift_en      		  ,
		Immed			  => immed_signal 		  		  , 		--signal--
		RF_A			  => rfa_signal    		  		  , 		--signal--
		RF_B		     => rfb_signal     		               --signal--

);

---------------------------------------------------------
PIPELINE_CONTROL_REGISTER_WB_M_EX: WB_M_EX_register_ID_EX

	PORT MAP
	(
		Clk  => Clk,
      RST  => Reset,
		WE   => '1',
		
      Data_RFA => rfa_signal,
	   Data_RFB => rfb_signal,
		Data_IMMED => immed_signal,
		
-- 		_________________________________
-- 		| THESE ARE THE CONTROL SIGNALS |
		
		Data_CONTROL(0)			 => signal_sel_16_immed,
		Data_CONTROL(1) 			 => signal_li_sel,
		Data_CONTROL(2) 			 => signal_ALU_Bin_sel,
		Data_CONTROL(6 downto 3) => signal_ALU_func ,
		Data_CONTROL(7) 			 => signal_sel_rfd_mask,
		Data_CONTROL(8) 			 => signal_MEM_WrEn,
		Data_CONTROL(9) 			 => signal_RF_WrEn,
		Data_CONTROL(10) 			 => signal_RF_WrData_sel,
		Data_CONTROL(11) 			 => signal_sel_mem_mask,
		
-- 		______
-- 		| RD |

      Data_RD => signal_Data_RD_1,
		
			  
		Dout_RFA => signal_Dout_RFA ,
		Dout_RFB => signal_Dout_RFB_1 ,
		Dout_IMMED => signal_Dout_IMMED ,
		Dout_CONTROL => signal_Dout_CONTROL_12 ,		  
      Dout_RD => signal_Dout_RD_1
	
	);

--_____________________________________________________________________










--_____________________________________________
exec: EXECSTAGE

PORT MAP(
 
	Clk => CLK,
   RST => Reset,
 
	RF_A         => signal_ALU_RFA_MUX_out				, --signal_Dout_RFA  , --signal-- CHANGED DEC_rfa_EXEC_signal
	RF_B         => signal_Dout_RFB_1    		 		, --signal-- CHANGED DEC_rfb_EXEC_signal
	Immed        => signal_Dout_IMMED   	 		   , --signal-- CHANGED immed_signal 
	
	Forward_control_sel => signal_FORWARD_B			,
	
	EXEC_B_IN 	 => signal_Dout_RFB_2,	   
	MEM_ALU_B_IN => signal_Dout_ALU_WB, 	
	MEM_B_IN     => signal_Dout_MEM_WB,
	
	
	sel_16_immed => signal_Dout_CONTROL_12(0)  		   , -- signal_sel_16_immed 
	li_sel       => signal_Dout_CONTROL_12(1)  		   , -- signal_li_sel
	ALU_BIN_sel  => signal_Dout_CONTROL_12(2)          , -- signal_ALU_BIN_sel
	ALU_func     => signal_Dout_CONTROL_12(6 downto 3) , -- signal_ALU_func 
	
	ALU_out 	    => alu_out_signal   		   	     --signal--

);
--_______________|REGISTER_1|_______________| EXEC_out -> MEM_in  

PIPELINE_CONTROL_REGISTER_WB_M: WB_M_register_EX_MEM	-- REPLACED WITH WB_M_register_EX_MEM

	PORT MAP
	(
			  Clk => CLK,
           RST => Reset,
			  WE  => '1',
			  
           Data_in => alu_out_signal,
			  Data_rfb => signal_Dout_RFB_1,

			  Data_CONTROL(0) 	=> signal_Dout_CONTROL_12(7),
			  Data_CONTROL(1) 	=> signal_Dout_CONTROL_12(8),
			  Data_CONTROL(2) 	=> signal_Dout_CONTROL_12(9),
			  Data_CONTROL(3) 	=> signal_Dout_CONTROL_12(10),
		     Data_CONTROL(4) 	=> signal_Dout_CONTROL_12(11),
			  
			  Data_rd => signal_Dout_RD_1,  
			  
           Dout_in 		=>	signal_Dout_in,
			  Dout_Control	=> signal_Dout_CONTROL_5,
			  Dout_rfb     => signal_Dout_RFB_2,
			  Dout_rd	   => signal_Dout_rd_2

	);
--_____________________________________________












--______________________________________________________
memory_stage: MEMSTAGE

PORT MAP(

	 a             => signal_Dout_in    			, -- signal --
    d             => signal_Dout_RFB_2     		, -- signal --
	 sel_rfd_mask  => signal_Dout_CONTROL_5(0)   , -- SEL_RFD_MASK
	 we            => signal_Dout_CONTROL_5(1)   , -- MEM_WREN
	 sel_mem_mask  => signal_Dout_CONTROL_5(4)   , -- SEL_MEM_MASK
    clk           => Clk                     	,
    spo 			   => mem_out_signal            	  -- signal --
);
--____________________|REGISTER|________________________||||||||||||||||||||||||||||||  PIPELINE REGISTER

PIPELINE_CONTROL_REGISTER_WB: WB_register_MEM_WB	-- WB_register_MEM_WB

	PORT MAP
	(
		 Clk => Clk,  	
       RST => Reset, 	
		 WE  => '1',		 		
			  
		 Data_MEM 	  =>	mem_out_signal	  ,
		 Data_ALU 	  =>	signal_Dout_in   , -- pitano thema
	    Data_RD 	  =>  signal_Dout_rd_2 ,
		 
		 Data_CONTROL(0) => signal_Dout_CONTROL_5(2),
		 Data_CONTROL(1) => signal_Dout_CONTROL_5(3)	, 
			 
		 Dout_MEM     =>	signal_Dout_MEM_WB,	
		 Dout_ALU     =>	signal_Dout_ALU_WB,
		 Dout_RD      =>  signal_Dout_RD_WB,	
		 Dout_CONTROL =>  signal_Dout_CONTROL_WB
		 
	);
--______________________________________________________









end Behavioral;