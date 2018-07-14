

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity SpecifyKeys is
Generic( clk_freq         : INTEGER := 100_000_000; --system clock frequency in Hz
         ps2_counter_size : INTEGER := 9);
         port(
           clk : in std_logic;
            scoreHomeOut,scoreAwayOut :out  std_logic_vector (11 downto 0);
            foulHomeOut,foulAwayOut : out std_logic_vector (3 downto 0);
            pause,reset1: out std_logic;   
            periodOut: out std_logic_vector(3 downto 0);
            PS2Clk      : IN  STD_LOGIC;                     --clock signal from PS/2 keyboard
            PS2Data     : IN  STD_LOGIC);
end SpecifyKeys;

architecture Behavioral of SpecifyKeys is
signal ps2_code :std_logic_vector(7 downto 0);
signal ps2_clk      :   STD_LOGIC;                     --clock signal from PS/2 keyboard
signal ps2_data, ps2_code_new     : STD_LOGIC; 
SIGNAL ps2_two_code :std_logic_vector(7 downto 0):= (others=> '0');
signal scoreHome,scoreAway: unsigned (11 downto 0):= (others=> '0');
signal foulHome,foulAway :unsigned (3 downto 0):= (others=> '0');
signal period: unsigned (3 downto 0):="0001";
signal pauseKey,resetKey,flag : std_logic := '1';

component ps2_keyboard
 GENERIC(
     clk_freq              : INTEGER;          --system clock frequency in Hz
     debounce_counter_size : INTEGER);   
port(
       clk: in std_logic;      
       ps2_clk      : IN  STD_LOGIC;                     --clock signal from PS/2 keyboard
       ps2_data     : IN  STD_LOGIC;                     --data signal from PS/2 keyboard
       ps2_code_new : OUT STD_LOGIC;             
       ps2_code: out std_logic_vector(7 downto 0)
       );
end component;

begin
scoreHomeOut<=std_logic_vector(scoreHome);
scoreAwayOut<=std_logic_vector(scoreAway);
foulHomeOut<=std_logic_vector(foulHome);
foulAwayOut<=std_logic_vector(foulAway);
reset1<=resetkey;
pause<=pausekey;
periodOut<=std_logic_vector(period);

process(clk,ps2_code, ps2_code_new)
begin
    if rising_edge(clk) then
        if ps2_code = x"f0" then
            flag<='1';
        end if; 
    --HOME TEAM
    --Score
        
    if ps2_code = x"15"and flag='1' then-- "15" is q 
        flag<='0';
        if  scoreHome(7 downto 0) >= "10011001" then -- if min xx:x9 => xx:10
            scoreHome(11 downto 8) <= (scoreHome(11 downto 8) + "0001");
            scoreHome(7 downto 0) <= "00000000";
        elsif scoreHome(3 downto 0) >= "1001" then -- if min xx:x9 => xx:10
            scoreHome(7 downto 4) <= (scoreHome(7 downto 4) + "0001"); 
            scoreHome(3 downto 0) <= "0000";
        else                
            scoreHome <=  scoreHome + "1";
        end if;
    end if;
    if ps2_code = x"1C" and flag='1' then -- "1C" is a
        flag<='0';
        if scoreHome(11 downto 0) = "000000000000" then
            scoreHome <= scoreHome;  
        elsif ((scoreHome(7 downto 0) <= "00000000") and (not(scoreHome(11 downto 8) <= "0000"))) then -- 
            scoreHome(11 downto 8) <= (scoreHome(11 downto 8) - "0001");
            scoreHome(7 downto 0) <= "10011001";
        elsif scoreHome(3 downto 0) <= "0000" then -- 
            scoreHome(7 downto 4) <= (scoreHome(7 downto 4) - "0001"); 
            scoreHome(3 downto 0) <= "1001";
        else                
            scoreHome <=  scoreHome - "000000000001";
        end if;
    end if;
    --Team fouls
    if ps2_code = x"24" and flag='1' then-- "24" is e
        flag<='0';
        if foulHome = "0101" then
            foulHome <= foulHome;  
        else 
            foulHome <= foulHome + 1;
        end if;
    end if;
    if ps2_code = x"23" and flag='1' then -- "23" is d
        flag<='0';
        if foulHome = "0000" then
            foulHome <= foulHome;  
        else 
            foulHome <= foulHome - 1;
        end if;
    end if;
    
    --Away team
    --Score
    if ps2_code = x"3c" and flag='1' then -- "3c" is u 
        flag<='0';
        if  scoreAway(7 downto 0) >= "10011001" then -- if min xx:x9 => xx:10
            scoreAway(11 downto 8) <= (scoreAway(11 downto 8) + "0001");
            scoreAway(7 downto 0) <= "00000000";
        elsif scoreAway(3 downto 0) >= "1001" then -- if min xx:x9 => xx:10
            scoreAway(7 downto 4) <= (scoreAway(7 downto 4) + "0001"); 
            scoreAway(3 downto 0) <= "0000";
        else                
            scoreAway <=  scoreAway + "1";
        end if;
    end if;
    if ps2_code = x"3B" and flag='1' then -- "3B" is j
        flag<='0';
        if scoreAway(11 downto 0) = "000000000000" then
            scoreAway <= scoreAway;        
        elsif ((scoreAway(7 downto 0) = "00000000") and (not(scoreAway(11 downto 8) <= "0000")))then -- if min xx:x9 => xx:10
            scoreAway(11 downto 8) <= (scoreAway(11 downto 8) - "0001");
            scoreAway(7 downto 0) <= "10011001";
        elsif scoreAway(3 downto 0) = "0000" then -- if min xx:x9 => xx:10
            scoreAway(7 downto 4) <= (scoreAway(7 downto 4) - "0001"); 
            scoreAway(3 downto 0) <= "1001";
        else                
            scoreAway <=  scoreAway - "1";
        end if;
    end if;
    --Team fouls
    if ps2_code = x"44" and flag='1' then -- "44" is o
        flag<='0';
        if foulAway >= "0101" then
            foulAway <= foulAway;  
        else 
            foulAway <= foulAway + 1;
        end if;
    end if;
    if ps2_code = x"4B" and flag='1' then -- "4B" is l
        flag<='0';
        if foulAway = "0000" then
            foulAway <= foulAway;  
        else 
            foulAway <= foulAway - 1;
        end if;
    end if;
    --other
    if ps2_code = x"29" and flag='1' then -- "29" is space
        flag<='0';
        resetKey <= '0';
        pauseKey <= not(pauseKey);     
    end if;
    if ps2_code = x"66" and flag='1' then -- "66" is backspace
        flag<='0';
        resetKey <= '1';
        pauseKey <= '1';
    end if;
    if ps2_code = x"12" and flag='1' then -- "12" is left shift
        flag<='0';
        if period = "0100" then
            period <= "1100";
        elsif period >="0101" then
            period <= "0000";
        else 
            period <= period + 1;
        end if;
    end if;
    if ps2_code = x"14" and flag='1' then -- "14" is left ctrl
        flag<='0';
        if period = "0000" then
            period <= period;
        elsif period = "1100" then
            period <= "0100";
        else 
            period <= period - "0001";
        end if;
    end if;
    end if;
end process;




keyboard: ps2_keyboard 
generic map(
clk_freq => clk_freq,
debounce_counter_size => ps2_counter_size)
port map(
  ps2_code_new =>ps2_code_new,
    clk=>clk,
     ps2_clk=>PS2Clk,
      ps2_data=>PS2Data,
    ps2_code=>ps2_code
);
end Behavioral;
