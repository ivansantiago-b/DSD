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
        clock, reset, go, comp_n, comp_i : in std_logic;
        ram_we, n_we, x_we, y_we, i_we, t_we: out std_logic;
        a : out std_logic_vector(7 downto 0); 
        a_selector : out std_logic_vector(2 downto 0);
        i_selector, y_selector, r_selector : out std_logic;
        r : out std_logic_vector(6 downto 0)
    );
end control_unit;

architecture Behavioral of control_unit is
    type state_t is (start, input, a1, a2, test_n, test_i, pop_x, pop_y, add_xy, push, done);
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
                next_state <= add_xy;
            when add_xy =>
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
    end process machine_input;

machine_output:
    process(clock, reset)
    begin
        if reset = '1' then
            a_selector <= "000";
            ram_we <= '0';
            n_we <= '0';
            i_we <= '0';
            x_we <= '0';
            y_we <= '0';
            t_we <= '0';
            i_selector <= '0';
            y_selector <= '0';
            r_selector <= '0';
        elsif rising_edge(clock) then
            case current_state is
                when input =>
                    a_selector <= "100";
                    a <= x"00";
                    r <= "0000000";
                    i_selector <= '0';
                    i_we <= '1';
                    n_we <= '1';
                    ram_we <= '1';
                when a1 =>
                    a <= x"01";
                    r <= "0000001";
                    i_we <= '0';
                when a2 =>
                    a <= x"02";
                when test_n =>
                    ram_we <= '0';
                when pop_x =>
                    a_selector <= "001";
                    x_we <= '1';
                when pop_y =>
                    x_we <= '0';
                    a_selector <= "010";
                    y_selector <= '0';
                    y_we <= '1';
                when add_xy =>
                    y_we <= '0';
                    a_selector <= "011";
                    y_selector <= '1';
                when push =>
                    y_we <= '1';
                    r_selector <= '1';
                    i_selector <= '1';
                    a_selector <= "001";
                    i_we <= '1';
                    ram_we <= '1';
                when test_i =>
                    y_we <= '0';
                    ram_we <= '0';
                    i_we <= '0';
                when done =>
                    a_selector <= "000";
                    t_we <= '1';
                when others =>
                    null;
            end case;
        end if;
    end process machine_output;
end Behavioral;
