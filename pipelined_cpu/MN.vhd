--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   13:08:00 06/22/2024
-- Design Name:   
-- Module Name:   /home/ise/pipelined_CPU/MN.vhd
-- Project Name:  pipelined_CPU
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: FORWARD_UNIT_MUX
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY MN IS
END MN;
 
ARCHITECTURE behavior OF MN IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT FORWARD_UNIT_MUX
    PORT(
         FORWARD_RFA_sel : IN  std_logic_vector(2 downto 0);
         normal_flow_A : IN  std_logic_vector(31 downto 0);
         EXEC_A : IN  std_logic_vector(31 downto 0);
         MEM_A : IN  std_logic_vector(31 downto 0);
         FORWARD_MUX_DOUT : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal FORWARD_RFA_sel : std_logic_vector(2 downto 0) := (others => '0');
   signal normal_flow_A : std_logic_vector(31 downto 0) := (others => '0');
   signal EXEC_A : std_logic_vector(31 downto 0) := (others => '0');
   signal MEM_A : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal FORWARD_MUX_DOUT : std_logic_vector(31 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   constant <clock>_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: FORWARD_UNIT_MUX PORT MAP (
          FORWARD_RFA_sel => FORWARD_RFA_sel,
          normal_flow_A => normal_flow_A,
          EXEC_A => EXEC_A,
          MEM_A => MEM_A,
          FORWARD_MUX_DOUT => FORWARD_MUX_DOUT
        );

   -- Clock process definitions
   <clock>_process :process
   begin
		<clock> <= '0';
		wait for <clock>_period/2;
		<clock> <= '1';
		wait for <clock>_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for <clock>_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
