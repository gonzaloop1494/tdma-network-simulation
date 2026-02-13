function SNR_instantanea = Apply_Rayleigh_Channel(SNR_dB, fd, num_muestras, ts)
% Apply_Rayleigh_Channel - Aplica el canal Rayleigh a la SNR media para obtener la SNR instantánea.
%   SNR_dB      - SNR media en dB (vector)
%   fd          - Frecuencia Doppler en Hz
%   num_muestras - Número de muestras del canal (en bloques de 32 símbolos)
%   ts          - Periodo de muestreo

K = length(SNR_dB);
SNR_instantanea = zeros(K, num_muestras);

% Creación del canal Rayleigh utilizando la toolbox de comunicaciones
for k = 1:K
    % Configuración del canal Rayleigh
    snr = 10.^(SNR_dB(k) / 10);
    num_bloques = num_muestras / 32;

    for n = 1:num_bloques
        % Reiniciar el canal Rayleigh en cada bloque para asegurar variabilidad
        ch = comm.RayleighChannel('SampleRate', 1/ts, 'MaximumDopplerShift', fd, 'PathGainsOutputPort', true);
        % Obtener las ganancias del canal para los 32 símbolos del bloque
        [~, H] = ch(ones(32, 1));

        % Mantener la coherencia del canal a lo largo del bloque
        for j = 1:32
            rayleigh_gain = sqrt(snr) * abs(H(j));
            SNR_instantanea(k, (n-1)*32 + j) = SNR_dB(k) + 10 * log10(rayleigh_gain^2);
        end
    end
end

end
