function [selected_user, selected_users, delay_vector, hist_SNR, retardos, user_tx_count] = Scheduler(SNR_instantanea, delay_vector, SNR_avg, algoritmo, Num_tramas)
% Scheduler - Elige el usuario a programar según el algoritmo elegido, considerando SNR instantánea cada 32 símbolos.
% Inputs:
%   SNR_instantanea - Matriz de SNRs instantáneas [dB], de tamaño K x Num_tramas
%   delay_vector    - Vector con los retrasos acumulados [tramas]
%   SNR_avg         - SNR promedio (solo para utilidad)
%   algoritmo       - 'maxSNR' o 'utilidad'
%   Num_tramas      - Número total de tramas
% Outputs:
%   selected_user     - Último usuario seleccionado
%   selected_users    - Vector con todos los usuarios seleccionados por trama
%   delay_vector      - Vector actualizado de retrasos
%   hist_SNR          - Historial de SNRs para cada usuario
%   retardos          - Historial de retrasos para cada usuario
%   user_tx_count     - Conteo de transmisiones por usuario

c = 5 * SNR_avg;  % Constante c, basada en la SNR media

K = size(SNR_instantanea, 1);  % Número de usuarios
selected_users = zeros(1, Num_tramas);     % Para guardar qué usuario transmite en cada trama
hist_SNR = cell(1, K);                     % Para guardar SNRs cuando transmite cada usuario
retardos = cell(1, K);                     % Para guardar retrasos cuando transmite cada usuario
user_tx_count = zeros(1, K);               % Contador de transmisiones por usuario

for i = 1:Num_tramas
    SNR_block = SNR_instantanea(:, i);  % SNR del instante actual (columna i)

    switch lower(algoritmo)
        case 'maxsnr'
            % Selección del usuario con el mayor SNR en el bloque
            [~, selected_user] = max(SNR_block);

        case 'utilidad'
            % Calcular la utilidad para cada usuario en función de su retraso
            d = delay_vector;
            d(d == 0) = 1;     % Evitar división por cero

            % Fórmula de utilidad
            utilidad = SNR_block + c ./ (20 - d);

            % Penalización para retrasos mayores a 19
            idx = d >= 20;
            if any(idx)
                utilidad(idx) = 2 * c;
            end

            % Selección del usuario con la mayor utilidad
            max_u = max(utilidad);
            candidatos = find(utilidad == max_u);
            if length(candidatos) > 1
                selected_user = candidatos(randi(length(candidatos)));
            else
                selected_user = candidatos;
            end

        otherwise
            error('Algoritmo no reconocido.');
    end

    selected_user = min(max(1, selected_user), K);  % Seguridad

    % Registrar el usuario seleccionado para esta trama
    selected_users(i) = selected_user;

    % Actualizar estadísticas
    hist_SNR{selected_user} = [hist_SNR{selected_user}, SNR_block(selected_user)];
    retardos{selected_user} = [retardos{selected_user}, delay_vector(selected_user)];

    % Incrementar el contador de transmisiones del usuario seleccionado
    user_tx_count(selected_user) = user_tx_count(selected_user) + 1;

    % Actualizar el vector de retrasos
    delay_vector = delay_vector + 1;
    delay_vector(selected_user) = 0;
end

end
