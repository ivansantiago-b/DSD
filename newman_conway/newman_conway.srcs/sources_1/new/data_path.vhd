----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/03/2023 01:06:52 PM
-- Design Name: 
-- Module Name: data_path - Behavioral
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

entity data_path is
    port(
        ra_sel : in std_logic_vector(1 downto 0);
        clock, reset : in std_logic;
        wa_sel, i_sel, y_sel, ri_sel : in std_logic;
        n_we, i_we, x_we, y_we, t_we, ram_we : in std_logic;
        n_in, i_ext, r: in std_logic_vector(7 downto 0);
        comp_n, comp_i : out std_logic;
        t : out std_logic_vector(7 downto 0)
    );
end data_path;

architecture Behavioral of data_path is
    signal wa, ra, x, y, y_in, i, i_in, inc_i, n, i_x, z : std_logic_vector(7 downto 0);
    signal ram_in, ram_out : std_logic_vector(7 downto 0);
begin
RAM:
    entity work.ram port map(clock => clock, we => ram_we, write_address => wa, read_address => ra, data_in => ram_in, data_out => ram_out);
    ram_in <= r when ri_sel = '1' else y;
    wa <= n when wa_sel = '1' else i;
    with ra_sel select
        ra <= i when "00",
              x when "01",
              n when "10",
              i_x when others;
    i_x <= i - x;
N_REG:
    entity work.register_8bit port map(clock => clock, reset => reset, we => n_we, data_in => n_in, data_out => n);
I_REG:
    entity work.register_8bit port map(clock => clock, reset => reset, we => i_we, data_in => i_in, data_out => i);
    i_in <= i_ext when i_sel = '1' else inc_i;
    inc_i <= i + 1;
X_REG:
    entity work.register_8bit port map(clock => clock, reset => reset, we => x_we, data_in => ram_out, data_out => x);
Y_REG:
    entity work.register_8bit port map(clock => clock, reset => reset, we => y_we, data_in => y_in, data_out => y);
    y_in <= ram_out when y_sel = '1' else z;
    z <= y + ram_out;
T_REG:
    entity work.register_8bit port map(clock => clock, reset => reset, we => t_we, data_in => ram_out, data_out => t);
N_COM:
    comp_n <= '1' when n < 3 else '0';
I_COM:
    comp_i <= '1' when i = n else '0';
end Behavioral;
