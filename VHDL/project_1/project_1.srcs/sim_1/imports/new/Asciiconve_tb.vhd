library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity Asciiconve_tb is
end;

architecture bench of Asciiconve_tb is

  component Asciiconve
      Port ( 
          clk:in std_logic;
          addr: in std_logic_vector(7 downto 0);
          dataOut: out std_logic_vector(7 downto 0)
  );
  end component;

  signal clk: std_logic;
  signal addr: std_logic_vector(7 downto 0);
  signal dataOut: std_logic_vector(7 downto 0) ;

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

  uut: Asciiconve port map ( clk     => clk,
                             addr    => addr,
                             dataOut => dataOut );

  stimulus: process
  begin
  
    -- Put initialisation code here
        addr <= "00000001";
        wait for 100 ns;
        addr <= "00010100"; --"01111000"
        wait for 200 ns;
        addr <= "00100011"; --"11000110"
        wait for 300 ns;
        addr <= "01100000";

    -- Put test bench stimulus code here

    wait;
  end process;

  clocking: process
  begin
    while not stop_the_clock loop
      clk <= '0', '1' after clock_period / 2;
      wait for clock_period;
    end loop;
    wait;
  end process;

end;