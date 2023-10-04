----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/26/2023 08:51:02 PM
-- Design Name: 
-- Module Name: control_unit - Behavioral
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

entity control_unit is
    port(
        clock, reset, go : in std_logic;
        comp_n, comp_i : in std_logic;
        wa_sel, i_sel, y_sel : out std_logic;
        ra_sel : out std_logic_vector(1 downto 0);
        n_we, i_we, x_we, y_we, t_we, ram_we : out std_logic;
        i_ext : out std_logic_vector(7 downto 0);
        r : out std_logic_vector(6 downto 0)
    );
end control_unit;

architecture Behavioral of control_unit is
    type state_t is (start, input, a1, a2, test_n, pop_x, pop_y, pop_z, push, test_i, done);
    signal current_state, next_state : state_t;
begin
state_register:
    process(clock, reset)
    begin
        if reset = '1' then
            current_state <= start;
        elsif rising_edge(clock) then
            current_state <= next_state;
        end if;
    end process state_register;
    
machine_input:
    process(current_state, go, comp_n, comp_i)
    begin
        case current_state is
            when start =>
                if go = '1' then
                    next_state <= input;
                else
                    next_state <= start;
                end if;
            when input =>
                next_state <= a1;
            when a1 =>
                next_state <= a2;
            when a2 =>
                next_state <= test_n;
            when test_n =>
                if comp_n = '1' then
                    next_state <= done;
                else
                    next_state <= pop_x;
                end if;
            when pop_x =>
                next_state <= pop_y;
            when pop_y =>
                next_state <= pop_z;
            when pop_z =>
                next_state <= push;
            when push =>
                next_state <= test_i;
            when test_i =>
                if comp_i = '1' then
                    next_state <= done;
                else
                    next_state <= pop_x;
                end if;
            when done =>
                next_state <= done;
            when others =>
                null;
        end case;
    end process;

machine_output:
    process(clock, reset, current_state)
    begin
        if reset = '1' then
            t_we <= '0';
            n_we <= '0';
            i_we <= '0';
            x_we <= '0';
            y_we <= '0';
            ram_we <= '0';
            i_sel <= '1';
            y_sel <= '0';
            wa_sel <= '1';
            ra_sel <= "00";
            r <= "0000000";
            i_ext <= x"00";
        elsif falling_edge(clock) then
            if current_state = input then
                n_we <= '1';
                i_we <= '1';
                ram_we <= '1';
            elsif current_state = a1 then
                n_we <= '0';
                i_ext <= x"01";
                r <= "0000001";
            elsif current_state = a2 then
                i_ext <= x"02";
                r <= "0000001";
            end if;
        end if;
    end process machine_output;
end Behavioral;
