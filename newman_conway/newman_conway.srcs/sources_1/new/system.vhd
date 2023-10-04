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
    signal counter : std_logic_vector(1 downto 0);
    signal slow_clock : std_logic;
begin
    process(master_clock, reset)
    begin
        if reset = '1' then
            counter <= (others => '0');
        elsif rising_edge(master_clock) then
            counter <= counter + 1;
        end if;
    end process;
    slow_clock <= counter(1);
U0:
    entity work.data_path port map(ra_sel => ra_sel, clock => master_clock, reset => reset, wa_sel => wa_sel, i_sel => i_sel, y_sel => y_sel, ri_sel => ri_sel, n_we => n_we, i_we => i_we, x_we => x_we, y_we => y_we, t_we => t_we, ram_we => ram_we, n_in => n, i_ext => i_ext, r => r, comp_n => comp_n, comp_i => comp_i, t => t);
U1:
    entity work.control_unit port map(clock => master_clock, reset => reset, go => button, comp_n => comp_n, comp_i => comp_i, wa_sel => wa_sel, i_sel => i_sel, y_sel => y_sel, ri_sel => ri_sel, ra_sel => ra_sel, n_we => n_we, i_we => i_we, x_we => x_we, y_we => y_we, t_we => t_we, ram_we => ram_we, i_ext => i_ext, r => r);
    
end Behavioral;
