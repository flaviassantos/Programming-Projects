

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ClockNBtn is
port(
        clk: in std_logic;
        pause,reset1: in std_logic; 
        --btnC_de: in std_logic; -- reset
        --btnR_de: in std_logic; --Increment/Decrement the minutes by a factor of 1 min
        --btnU_de: in std_logic; -- Increment/Decrement the hour by a factor of 1hour
        --btnD_de: in std_logic; --Increment/Decrement the minutes by a factor of 10 min
        --o_sw: in std_logic; --increment sw='0' and decrement sw='1' values in 'set' function
        num: out  std_logic_vector (15 downto 0));
      
      
end ClockNBtn;

architecture Behavioral of ClockNBtn is

signal sec_tenth : INTEGER range 0 to 10 := 9;
signal sec_clock : INTEGER range 0 to 100 := 9;
signal counter : INTEGER range 0 to 100000050 := 0; -- Basys3 has 100M cycles per second
signal counter_bin : unsigned (15 downto 0) := "0001000000000000";
signal last_min : std_logic := '0';
signal test : std_logic_vector(3 downto 0);

begin 

num <= std_logic_vector(counter_bin); 

counter_clock1: process(clk)
begin
    if rising_edge (clk) then           
        if reset1 = '1' then --reset button, displays '0's
            counter <= 0;        
            last_min <= '0';
            counter_bin <= "0001000000000000";
            sec_tenth <= 9;         
        elsif pause = '1' then
            counter_bin <= counter_bin;  
        elsif counter >= 10000000 then -- counts every 100th second
            sec_tenth <= sec_tenth - 1;
            if last_min = '1' then
                 counter_bin(15 downto 0) <= (counter_bin(15 downto 8) & (to_unsigned(sec_tenth,test'length)) & "0000");                                        
                 if (counter_bin(15 downto 8) = "00000000") then
                     counter_bin(15 downto 0) <= "0000000000000000";
                     last_min <= '0';                                  
                 end if; 
            end if;        
            if (sec_tenth = 0) then
                sec_tenth <= 9;
                if last_min = '0' then                  
                    if (counter_bin(15 downto 0) = "0001000000000000") then -- checks if more than 24:00, resets
                        counter_bin <= "0000100101011001";
                    elsif (counter_bin(11 downto 0) = "000100000000") then
                        last_min <= '1';                         
                        counter_bin(15 downto 8) <= "01011001";
                    elsif (counter_bin(15 downto 0) = "0000000000000000") then
                        counter_bin(15 downto 0) <= "0000000000000000";                                 
                    elsif (counter_bin(7 downto 0) = "00000000") then -- checks if more than x9:xx, resets
                        counter_bin(11 downto 8) <= counter_bin(11 downto 8) - "0001"; 
                        counter_bin(7 downto 0) <= "01011001";    
                    elsif (counter_bin(3 downto 0) = "0000") then -- checks if more than xx:59, resets
                        counter_bin(7 downto 4) <= counter_bin(7 downto 4) - "0001";
                        counter_bin(3 downto 0) <= "1001";             
                    else
                        counter_bin <= counter_bin - "0000000000000001";                                                                             
                    end if;
                else
                    if (counter_bin(11 downto 8) = "0000") then -- checks if more than xx:59, resets
                        counter_bin(15 downto 12) <= counter_bin(15 downto 12) - "0001";
                        counter_bin(11 downto 8) <= "1001";
                    else              
                        counter_bin(15 downto 8) <= counter_bin(15 downto 8) - "00000001";
                    end if;                     
                end if;
            end if;
            counter <= 0;            
        else
            counter <= counter + 1; 
        end if;          
    end if;
end process;    

end Behavioral;
