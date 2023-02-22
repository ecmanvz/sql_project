--
-- PostgreSQL database dump
--

-- Dumped from database version 11.5
-- Dumped by pg_dump version 12rc1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: ara(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.ara(isim integer) RETURNS TABLE(kitapid integer, rafadres character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
   RETURN QUERY SELECT "kitapId", "rafAdres" FROM "kitap"
                 WHERE "kitapId" = isim;
end;
$$;


ALTER FUNCTION public.ara(isim integer) OWNER TO postgres;

--
-- Name: ara(character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.ara(isim character varying) RETURNS TABLE(adi character varying, rafadres character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
   RETURN QUERY SELECT "Kitapadi", "rafAdres" FROM "kitap"
                 WHERE "Kitapadi" = isim;
end;
$$;


ALTER FUNCTION public.ara(isim character varying) OWNER TO postgres;

--
-- Name: istek_kitap_ekle(character varying, character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.istek_kitap_ekle(isim character varying, yazar_adi character varying, kisi_no character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
    INSERT into "kitapIste"("kitapAdi","yazarAdi","numara")
    VALUES(isim,yazar_adi,kisi_no);
    if FOUND THEN
        return 1;
    else return 0;
    end if; 
end
$$;


ALTER FUNCTION public.istek_kitap_ekle(isim character varying, yazar_adi character varying, kisi_no character varying) OWNER TO postgres;

--
-- Name: kitapekle(character varying, integer, integer, character varying, integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.kitapekle(isim character varying, kitapid integer, konuid integer, rafadres character varying, sayfa_sayisi integer, yazar_id integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
    INSERT into "kitap"("adi","kitapId","konuId","rafAdres","sayfasayisi","yazarId")
    VALUES(isim,kitapid,konuid,rafadres,sayfa_sayisi,yazar_id);
    if FOUND THEN
        return 1;
    else return 0;
    end if; 
end
$$;


ALTER FUNCTION public.kitapekle(isim character varying, kitapid integer, konuid integer, rafadres character varying, sayfa_sayisi integer, yazar_id integer) OWNER TO postgres;

--
-- Name: kitapekle(character varying, integer, integer, character varying, integer, integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.kitapekle(isim character varying, kitapid integer, konuid integer, rafadres character varying, sayfa_sayisi integer, tur_id integer, yazar_id integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
    INSERT into "kitap"("adi","kitapId","konuId","rafAdres","sayfasayisi","turId","yazarId")
    VALUES(isim,kitapid,konuid,rafadres,sayfa_sayisi,tur_id,yazar_id);
    if FOUND THEN
        return 1;
    else return 0;
    end if; 
end
$$;


ALTER FUNCTION public.kitapekle(isim character varying, kitapid integer, konuid integer, rafadres character varying, sayfa_sayisi integer, tur_id integer, yazar_id integer) OWNER TO postgres;

--
-- Name: oduncal(character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.oduncal(_isim character varying, _raf character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
    if(SELECT count(*) from "kitap" where "Kitapadi"=_isim and "rafAdres"=_raf)> 0 THEN
    DELETE FROM "kitap"
    where "Kitapadi"=_isim
    AND "rafAdres"=_raf;
        return 1;
    else
        return 0;
    end if;
 end
 $$;


ALTER FUNCTION public.oduncal(_isim character varying, _raf character varying) OWNER TO postgres;

--
-- Name: rafGüncelle(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public."rafGüncelle"() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF NEW."rafdurum" <> OLD."rafdurum" THEN
        INSERT INTO "raf"("rafId","rafDurum", "rafKonum")
        VALUES(NEW."rafId", NEW."rafdurum", NEW."rafdurum");
    END IF;

    RETURN NEW;
END;
$$;


ALTER FUNCTION public."rafGüncelle"() OWNER TO postgres;

--
-- Name: rafgüncelle(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public."rafgüncelle"() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF NEW."rafdurum" <> OLD."rafdurum" THEN
        INSERT INTO "raf"("rafId","rafDurum", "rafKonum")
        VALUES(OLD."rafId", OLD."rafdurum", NEW."rafdurum");
    END IF;

    RETURN NEW;
END;
$$;


ALTER FUNCTION public."rafgüncelle"() OWNER TO postgres;

--
-- Name: sifre_guncelle(character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.sifre_guncelle("kullanıcı_no" character varying, yeni_sifre character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
    update "hesap"
    set
    sifre=yeni_sifre
    WHERE "numara"=kullanıcı_no;
    if found then
        return 1;
    else 
        return 0;
    end if;
end
$$;


ALTER FUNCTION public.sifre_guncelle("kullanıcı_no" character varying, yeni_sifre character varying) OWNER TO postgres;

--
-- Name: sorgu1(character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.sorgu1(isim character varying) RETURNS TABLE(adi character varying, rafadres character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
   RETURN QUERY SELECT "adi", "rafAdres" FROM "kitap"
                 WHERE "adi" = isim;
end
$$;


ALTER FUNCTION public.sorgu1(isim character varying) OWNER TO postgres;

--
-- Name: u_giris(character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.u_giris(_username character varying, _password character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
    if(SELECT count(*) from "hesap" where numara=_username and sifre =_password)> 0 THEN
        return 1; 
    else
        return 0;
    end if;
end
$$;


ALTER FUNCTION public.u_giris(_username character varying, _password character varying) OWNER TO postgres;

SET default_tablespace = '';

--
-- Name: emanet; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.emanet (
    "kitapId" integer NOT NULL,
    "emanetAlanNo" character varying(2044) NOT NULL,
    "Id" integer NOT NULL,
    "rafId" integer NOT NULL
);


ALTER TABLE public.emanet OWNER TO postgres;

--
-- Name: hesap; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.hesap (
    numara character varying(2044) NOT NULL,
    mail character varying(2044) NOT NULL,
    bolum character varying(2044) NOT NULL,
    cinsiyet character varying(2044) NOT NULL,
    sifre character varying(2044) NOT NULL,
    sinif character varying(2044) NOT NULL,
    kisiadi character varying(2044) NOT NULL
);


ALTER TABLE public.hesap OWNER TO postgres;

--
-- Name: hesapKutuphane; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."hesapKutuphane" (
    "kutuphaneId" integer NOT NULL,
    numara character varying(2044) NOT NULL
);


ALTER TABLE public."hesapKutuphane" OWNER TO postgres;

--
-- Name: kitap; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.kitap (
    "Kitapadi" character varying(40) NOT NULL,
    "kitapId" integer NOT NULL,
    "konuId" integer NOT NULL,
    "rafAdres" character varying(40),
    sayfasayisi integer NOT NULL,
    "turId" integer NOT NULL,
    "yazarId" integer NOT NULL
);


ALTER TABLE public.kitap OWNER TO postgres;

--
-- Name: kitapIste; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."kitapIste" (
    "kitapAdi" character varying(2044) NOT NULL,
    "yazarAdi" character varying(2044) NOT NULL,
    numara character varying(2044) NOT NULL
);


ALTER TABLE public."kitapIste" OWNER TO postgres;

--
-- Name: kitapKonu; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."kitapKonu" (
    "kitapId" integer NOT NULL,
    "konuId" integer NOT NULL
);


ALTER TABLE public."kitapKonu" OWNER TO postgres;

--
-- Name: konu; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.konu (
    "konuId" integer NOT NULL,
    "konuAdi" character varying(2044) NOT NULL
);


ALTER TABLE public.konu OWNER TO postgres;

--
-- Name: kutuphane; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.kutuphane (
    "kutuphaneId" integer NOT NULL,
    fakulte character varying(2044) NOT NULL,
    adres character varying(2044) NOT NULL
);


ALTER TABLE public.kutuphane OWNER TO postgres;

--
-- Name: raf; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.raf (
    "rafKonum" integer NOT NULL,
    "rafAdres" character varying(40) NOT NULL,
    "rafDurum" character varying(20) NOT NULL,
    "kutuphaneId" integer NOT NULL,
    "rafId" integer NOT NULL
);


ALTER TABLE public.raf OWNER TO postgres;

--
-- Name: tur; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tur (
    "turAdi" character varying(2044) NOT NULL,
    "turId" integer NOT NULL
);


ALTER TABLE public.tur OWNER TO postgres;

--
-- Name: yazar; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.yazar (
    "yazarId" integer NOT NULL,
    "yazarAdi" character varying(2044) NOT NULL
);


ALTER TABLE public.yazar OWNER TO postgres;

--
-- Name: yazarkitap; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.yazarkitap (
    "yazarId" integer NOT NULL,
    "kitapId" integer NOT NULL
);


ALTER TABLE public.yazarkitap OWNER TO postgres;

--
-- Data for Name: emanet; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: hesap; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.hesap VALUES ('g181', 'aliali', 'bilgisayar', 'erkek', '12', '1', 'ali demir');


--
-- Data for Name: hesapKutuphane; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: kitap; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.kitap VALUES ('Av', 10, 10, 'b10', 10, 10, 10);
INSERT INTO public.kitap VALUES ('Sinekli Bakkal', 12, 12, 'b10', 12, 12, 12);
INSERT INTO public.kitap VALUES ('Seker Portakali', 11, 11, 'b11', 11, 11, 11);


--
-- Data for Name: kitapIste; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."kitapIste" VALUES ('Sinekli Bakkal', 'Halide', 'g181');
INSERT INTO public."kitapIste" VALUES ('Babalar ve Oğullar', 'İvan Turgenyev', 'g181');
INSERT INTO public."kitapIste" VALUES ('satranc', 'stefan zweig', 'g181');
INSERT INTO public."kitapIste" VALUES ('uyuyan adam', 'geogre', 'g181');
INSERT INTO public."kitapIste" VALUES ('Satranc', 'stefan zweig', 'g181');


--
-- Data for Name: kitapKonu; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."kitapKonu" VALUES (10, 10);


--
-- Data for Name: konu; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.konu VALUES (12, 'roman');
INSERT INTO public.konu VALUES (10, 'roman');


--
-- Data for Name: kutuphane; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.kutuphane VALUES (12, 'bilgisayar', '12');
INSERT INTO public.kutuphane VALUES (10, 'bilgisayar', '10');


--
-- Data for Name: raf; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.raf VALUES (10, 'b10', 'var', 10, 10);
INSERT INTO public.raf VALUES (12, 'b12', 'var', 12, 12);


--
-- Data for Name: tur; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.tur VALUES ('roman', 12);
INSERT INTO public.tur VALUES ('roman', 10);
INSERT INTO public.tur VALUES ('roman', 1);
INSERT INTO public.tur VALUES ('roman', 11);


--
-- Data for Name: yazar; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.yazar VALUES (12, 'Halide');
INSERT INTO public.yazar VALUES (10, 'jule');
INSERT INTO public.yazar VALUES (11, 'ali');


--
-- Data for Name: yazarkitap; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.yazarkitap VALUES (12, 12);
INSERT INTO public.yazarkitap VALUES (10, 10);
INSERT INTO public.yazarkitap VALUES (11, 11);


--
-- Name: hesapKutuphane hesapKutuphane_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."hesapKutuphane"
    ADD CONSTRAINT "hesapKutuphane_pkey" PRIMARY KEY ("kutuphaneId", numara);


--
-- Name: hesap hesap_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hesap
    ADD CONSTRAINT hesap_pkey PRIMARY KEY (numara);


--
-- Name: kitapKonu kitapKonu_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."kitapKonu"
    ADD CONSTRAINT "kitapKonu_pkey" PRIMARY KEY ("kitapId", "konuId");


--
-- Name: kutuphane kutuphane_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kutuphane
    ADD CONSTRAINT kutuphane_pkey PRIMARY KEY ("kutuphaneId");


--
-- Name: raf raf_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.raf
    ADD CONSTRAINT raf_pkey PRIMARY KEY ("rafId");


--
-- Name: emanet unique_emanet_Id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.emanet
    ADD CONSTRAINT "unique_emanet_Id" PRIMARY KEY ("Id");


--
-- Name: hesapKutuphane unique_hesapKutuphane_hesapId; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."hesapKutuphane"
    ADD CONSTRAINT "unique_hesapKutuphane_hesapId" UNIQUE (numara);


--
-- Name: hesapKutuphane unique_hesapKutuphane_kutuphaneId; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."hesapKutuphane"
    ADD CONSTRAINT "unique_hesapKutuphane_kutuphaneId" UNIQUE ("kutuphaneId");


--
-- Name: hesap unique_hesap_numara; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hesap
    ADD CONSTRAINT unique_hesap_numara UNIQUE (numara);


--
-- Name: kitapIste unique_kitapIste_kitapAdi; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."kitapIste"
    ADD CONSTRAINT "unique_kitapIste_kitapAdi" PRIMARY KEY ("kitapAdi");


--
-- Name: kitapKonu unique_kitapKonu_kitapId; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."kitapKonu"
    ADD CONSTRAINT "unique_kitapKonu_kitapId" UNIQUE ("kitapId");


--
-- Name: kitapKonu unique_kitapKonu_konuId; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."kitapKonu"
    ADD CONSTRAINT "unique_kitapKonu_konuId" UNIQUE ("konuId");


--
-- Name: kitap unique_kitap_adi; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kitap
    ADD CONSTRAINT unique_kitap_adi PRIMARY KEY ("Kitapadi");


--
-- Name: kitap unique_kitap_kitapId; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kitap
    ADD CONSTRAINT "unique_kitap_kitapId" UNIQUE ("kitapId");


--
-- Name: konu unique_konu_konuId; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.konu
    ADD CONSTRAINT "unique_konu_konuId" PRIMARY KEY ("konuId");


--
-- Name: raf unique_raf_rafId; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.raf
    ADD CONSTRAINT "unique_raf_rafId" UNIQUE ("rafId");


--
-- Name: tur unique_tur_turId; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tur
    ADD CONSTRAINT "unique_tur_turId" PRIMARY KEY ("turId");


--
-- Name: yazar unique_yazar_adi; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.yazar
    ADD CONSTRAINT unique_yazar_adi PRIMARY KEY ("yazarId");


--
-- Name: yazarkitap unique_yazarkitap_kitapId; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.yazarkitap
    ADD CONSTRAINT "unique_yazarkitap_kitapId" UNIQUE ("kitapId");


--
-- Name: yazarkitap yazarkitap_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.yazarkitap
    ADD CONSTRAINT yazarkitap_pkey PRIMARY KEY ("yazarId", "kitapId");


--
-- Name: index_kutuphaneId; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "index_kutuphaneId" ON public."hesapKutuphane" USING btree ("kutuphaneId");


--
-- Name: index_yazarId; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "index_yazarId" ON public.yazarkitap USING btree ("yazarId");


--
-- Name: raf güncelleRaf; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "güncelleRaf" BEFORE UPDATE ON public.raf FOR EACH ROW EXECUTE PROCEDURE public."rafGüncelle"();


--
-- Name: emanet lnk_hesap_emanet; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.emanet
    ADD CONSTRAINT lnk_hesap_emanet FOREIGN KEY ("emanetAlanNo") REFERENCES public.hesap(numara) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: hesapKutuphane lnk_hesap_hesapKutuphane; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."hesapKutuphane"
    ADD CONSTRAINT "lnk_hesap_hesapKutuphane" FOREIGN KEY (numara) REFERENCES public.hesap(numara) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: kitapIste lnk_hesap_kitapIste; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."kitapIste"
    ADD CONSTRAINT "lnk_hesap_kitapIste" FOREIGN KEY (numara) REFERENCES public.hesap(numara) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: emanet lnk_kitap_emanet; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.emanet
    ADD CONSTRAINT lnk_kitap_emanet FOREIGN KEY ("kitapId") REFERENCES public.kitap("kitapId") MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: kitapKonu lnk_kitap_kitapKonu; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."kitapKonu"
    ADD CONSTRAINT "lnk_kitap_kitapKonu" FOREIGN KEY ("kitapId") REFERENCES public.kitap("kitapId") MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: kitapKonu lnk_konu_kitapKonu; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."kitapKonu"
    ADD CONSTRAINT "lnk_konu_kitapKonu" FOREIGN KEY ("konuId") REFERENCES public.konu("konuId") MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: hesapKutuphane lnk_kutuphane_hesapKutuphane; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."hesapKutuphane"
    ADD CONSTRAINT "lnk_kutuphane_hesapKutuphane" FOREIGN KEY ("kutuphaneId") REFERENCES public.kutuphane("kutuphaneId") MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: raf lnk_kutuphane_raf; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.raf
    ADD CONSTRAINT lnk_kutuphane_raf FOREIGN KEY ("kutuphaneId") REFERENCES public.kutuphane("kutuphaneId") MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: emanet lnk_raf_emanet; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.emanet
    ADD CONSTRAINT lnk_raf_emanet FOREIGN KEY ("rafId") REFERENCES public.raf("rafId") MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: kitap lnk_tur_kitap; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kitap
    ADD CONSTRAINT lnk_tur_kitap FOREIGN KEY ("turId") REFERENCES public.tur("turId") MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: yazarkitap lnk_yazar_yazarkitap; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.yazarkitap
    ADD CONSTRAINT lnk_yazar_yazarkitap FOREIGN KEY ("yazarId") REFERENCES public.yazar("yazarId") MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: kitap lnk_yazarkitap_kitap; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kitap
    ADD CONSTRAINT lnk_yazarkitap_kitap FOREIGN KEY ("kitapId") REFERENCES public.yazarkitap("kitapId") MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

