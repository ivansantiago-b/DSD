----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/30/2023 12:12:13 AM
-- Design Name: 
-- Module Name: system - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity system is
    port(
        x, y : in std_logic_vector(7 downto 0);
        master_clock, reset, button: in std_logic;
        anodes : out std_logic_vector(3 downto 0);
        cathodes : out std_logic_vector(6 downto 0)
    );
end system;

architecture Behavioral of system is
    signal slow_clock : std_logic;
    signal counter : std_logic_vector(18 downto 0);
    signal flags : std_logic_vector(2 downto 0);
    signal gcd: std_logic_vector(7 downto 0);
    signal x7seg_in : std_logic_vector(15 downto 0);
    signal x_we, y_we, x_sel, y_sel, gcd_we: std_logic;
    signal delay0, delay1, delay2, delay3, delay4, delay5, debounce, pulse: std_logic;
begin
frequency_divider:
    process(master_clock, reset)
    begin
        if reset = '1' then
            counter <= (others => '0');
        elsif rising_edge(master_clock) then
            counter <= counter + 1;
        end if;
    end process frequency_divider;
    slow_clock <= counter(18);
button_debounce:
    process(slow_clock, reset)
    begin
        if reset = '1' then
            delay0 <= '0';
            delay1 <= '0';
            delay2 <= '0';
        elsif rising_edge(slow_clock) then
            delay0 <= button;
            delay1 <= delay0;
            delay2 <= delay1;
        end if;
    end process button_debounce;
    debounce <= delay0 and delay1 and delay2;
button_pulse:
    process(slow_clock, reset)
    begin
        if reset = '1' then
            delay3 <= '0';
            delay4 <= '0';
            delay5 <= '0';
        elsif rising_edge(slow_clock) then
            delay3 <= debounce;
            delay4 <= delay3;
            delay5 <= delay4;
        end if;
    end process button_pulse;
    pulse <= delay3 and delay4 and (not delay5);
U0:
    entity work.data_path port map(clock => master_clock, reset => reset, x_in => x, y_in => y, x_sel => x_sel, y_sel => y_sel, x_we => x_we, y_we => y_we, gcd_we => gcd_we, flags => flags, gcd => gcd);
U1:
    entity work.control_unit port map(clock => master_clock, reset => reset, go => pulse, flags => flags, x_we => x_we, y_we => y_we, x_sel => x_sel, y_sel => y_sel, gcd_we => gcd_we);
U3:
    entity work.x7seg port map(clock => slow_clock, reset => reset, x => x7seg_in, anodes => anodes, cathodes => cathodes);
    x7seg_in(15 downto 8) <= (others => '0');
    x7seg_in(7 downto 0) <= gcd;
end Behavioral;

