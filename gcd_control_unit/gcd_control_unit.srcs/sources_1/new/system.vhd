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
    signal delay1, delay2, delay3, delay4, delay5, delay6, slow_clock, debounced_button, pulse_button: std_logic;
    signal counter : std_logic_vector(18 downto 0);
    signal flags : std_logic_vector(2 downto 0);
    signal x_gcd, gcd: std_logic_vector(7 downto 0);
    signal x_in : std_logic_vector(15 downto 0);
    signal x_we, y_we, x_sel, y_sel, gcd_we: std_logic;
begin
frequency_divider:
    process(master_clock, reset)
    begin
        if reset = '1' then
            counter <= (others => '0');
        elsif rising_edge(master_clock) then
            counter <= counter + 1;
        end if;
    end process;
    slow_clock <= counter(18);
debounce:
    process(slow_clock, reset)
    begin
        if reset = '1' then
            delay1 <= '0';
            delay2 <= '0';
            delay3 <= '0';
        elsif rising_edge(slow_clock) then
            delay1 <= button;
            delay2 <= delay1;
            delay3 <= delay2;
        end if;
    end process;
    debounced_button <= delay1 and delay2 and delay3;
pulse:
    process(slow_clock, reset)
    begin
        if reset = '1' then
            delay4 <= '0';
            delay5 <= '0';
            delay6 <= '0';
        elsif rising_edge(slow_clock) then
            delay4 <= debounced_button;
            delay5 <= delay4;
            delay6 <= delay5;
        end if;
    end process;
    pulse_button <= delay4 and delay5 and (not delay6);
U0:
    entity work.control_unit port map(clock => master_clock, reset => reset, go => pulse_button, flags => flags, x_we => x_we, y_we => y_we, x_sel => x_sel, y_sel => y_sel, gcd_we => gcd_we);
U1:
    entity work.data_path port map(clock => master_clock, reset => reset, x_we => x_we, y_we => y_we, x_in => x, y_in => y, x_selector => x_sel, y_selector => y_sel, flags => flags, gcd => x_gcd);
U2:
    entity work.register_8bit port map(clock => master_clock, reset => reset, we => gcd_we, data_in => x_gcd, data_out => gcd);
U3:
    entity work.x7seg port map(clock => slow_clock, reset => reset, x => x_in, anodes => anodes, cathodes => cathodes);
    x_in <= "00000000" & gcd;
end Behavioral;
