----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/03/2023 02:32:40 PM
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
        master_clock, reset, button: in std_logic;
        n : in std_logic_vector(7 downto 0);
        anodes : out std_logic_vector(3 downto 0);
        cathodes : out std_logic_vector(6 downto 0)
    );
end system;

architecture Behavioral of system is
    signal ra_sel : std_logic_vector(1 downto 0);
    signal wa_sel, i_sel, y_sel, ri_sel, n_we, i_we, x_we, y_we, t_we, ram_we, comp_n, comp_i : std_logic;
    signal i_ext, t, r: std_logic_vector(7 downto 0);
    signal counter : std_logic_vector(18 downto 0);
    signal slow_clock : std_logic;
    signal x7seg : std_logic_vector(15 downto 0);
    signal first_delay, second_delay, third_delay, fourth_delay, pulse : std_logic;
begin
frequency_divisor:
    process(master_clock, reset)
    begin
        if reset = '1' then
            counter <= (others => '0');
        elsif rising_edge(master_clock) then
            counter <= counter + 1;
        end if;
    end process frequency_divisor;
    slow_clock <= counter(18);
button_pulse:
    process(master_clock, reset)
    begin
        if reset = '1' then
            first_delay <= '0';
            second_delay <= '0';
            third_delay <= '0';
            fourth_delay <= '0';
        elsif rising_edge(master_clock) then
            first_delay <= button;
            second_delay <= first_delay;
            third_delay <= first_delay and second_delay;
            fourth_delay <= third_delay;
        end if;
    end process button_pulse;
    pulse <= third_delay and (not fourth_delay);
U0:
    entity work.data_path port map(ra_sel => ra_sel, clock => master_clock, reset => reset, wa_sel => wa_sel, i_sel => i_sel, y_sel => y_sel, ri_sel => ri_sel, n_we => n_we, i_we => i_we, x_we => x_we, y_we => y_we, t_we => t_we, ram_we => ram_we, n_in => n, i_ext => i_ext, r => r, comp_n => comp_n, comp_i => comp_i, t => t);
U1:
    entity work.control_unit port map(clock => master_clock, reset => reset, go => pulse, comp_n => comp_n, comp_i => comp_i, wa_sel => wa_sel, i_sel => i_sel, y_sel => y_sel, ri_sel => ri_sel, ra_sel => ra_sel, n_we => n_we, i_we => i_we, x_we => x_we, y_we => y_we, t_we => t_we, ram_we => ram_we, i_ext => i_ext, r => r);
U2:
    entity work.x7seg port map(clock => slow_clock, reset => reset, x => x7seg, anodes => anodes, cathodes => cathodes);
    x7seg(15 downto 8) <= (others => '0');
    x7seg(7 downto 0) <= t;
end Behavioral;
