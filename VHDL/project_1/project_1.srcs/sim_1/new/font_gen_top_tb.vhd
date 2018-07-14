----------------------------------------------------------------------------------
-- Description: Test bench file simulation for the top file.

-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity font_test_top_tb is
--  Port ( );
end font_test_top_tb;

architecture Behavioral of font_test_top_tb is

COMPONENT font_test_top
port(
      clk : in std_logic;
      btnC: in std_logic; -- reset
      btnR: in std_logic; --Increment/Decrement the minutes by a factor of 1 min
      btnU: in std_logic; -- Increment/Decrement the hour by a factor of 1hour
      btnD: in std_logic; --Increment/Decrement the minutes by a factor of 10 min
      sw: in std_logic_vector(1 downto 0);   
      Hsync, Vsync: out std_logic;
      rgb: out std_logic_vector (11 downto 0) 
  );
end component;

--Inputs
signal clk: std_logic;
signal btnC: std_logic; -- reset clock
signal btnR: std_logic; --Increment/Decrement the minutes by a factor of 1 min
signal btnU: std_logic; -- Increment/Decrement the hour by a factor of 1hour
signal btnD: std_logic; --Increment/Decrement the minutes by a factor of 10 min
signal sw: std_logic_vector(1 downto 0);   -- sw(o): increment/decrement and sw(1): reset debounce and vga_sync

--Outputs
signal rgb: std_logic_vector(11 downto 0);
signal Hsync, Vsync: std_logic;
-- Clock period definitions 
constant clk_period : time := 10 ns;

begin
-- Instantiate the Unit Under Test (UUT)

UUT: font_test_top port map(
         clk => clk,
         btnC => btnC, --resert clock
         btnR => btnR,
         btnU => btnU,
         btnD => btnD,
         sw(0) => sw(0),
         sw(1) => sw(1), --reset debounce and vga_sync
         Hsync => Hsync,
         Vsync => Vsync,
         rgb => rgb );
         
 -- Clock process definitions
         clk_process :process 
         begin
         clk <= '0'; 
         wait for clk_period/2;
         clk <= '1'; 
         wait for clk_period/2;
         end process;

 -- Stimulus process 
         stim_proc: process
         begin 
         btnC <= '1'; -- reset
         sw(1) <= '1';
         wait for  200 ns; 
         btnC <= '0';
         sw(1) <= '0';
         
        ---increment---
         sw(0) <= '0'; 
         btnR <= '1';
         wait for 200 ns;
         
         btnR <= '0';
         btnU <= '1';
         wait for 200 ns;
         
         btnU <= '0';
         btnD <= '1';
         wait for 200 ns;
         
         btnD <= '0';
     
         
        ---decrement---
         
         btnR <= '1';
         wait for 200 ns;
         
         btnR <= '0';
         btnU <= '1';
         wait for 200 ns;
         
         btnU <= '0';
         btnD <= '1';
         wait for 200 ns;
         
         btnD <= '0';
         wait for 200 ns;
       wait;
       end process;

end Behavioral;
