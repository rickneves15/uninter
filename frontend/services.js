const URL_BASE = "http://localhost:8000/api";
const CARD_MODEL_1 = jQuery("#card-modelo-1").clone();
const CARD_MODEL_2 = jQuery("#card-modelo-2").clone();

jQuery(() => {
  console.log("Ready disparado");

  getAllCourses().then((data) => fillCoursesFilter(data));
  getAllTeachers().then((data) => fillTeachersFilter(data));
  getAllCards().then(async (data) => {
    fillCards(data.cards);
    fillNumberClassesFilter(data.numero_aulas);
    fillNumberStatusColumn(data.quantidade_status);
  });
});

const getAllCourses = async () => {
  const response = await fetch(`${URL_BASE}/curso`);
  const courses = await response.json();

  return courses;
};

const fillCoursesFilter = (courses) => {
  const coursesElement = jQuery("#select-filtro-curso");
  courses.forEach((course) => {
    coursesElement.append(
      `"<option value='${course.id_curso}'>${course.curso}</option>"`
    );
  });
};

const getAllTypes = async () => {
  const response = await fetch(`${URL_BASE}/tipo`);
  const types = await response.json();

  return types;
};

const getAllTeachers = async () => {
  const response = await fetch(`${URL_BASE}/professor`);
  const teachers = await response.json();

  return teachers;
};

const fillTeachersFilter = (teachers) => {
  const teachersElement = jQuery("#select-filtro-professor");
  teachers.forEach((teacher) => {
    teachersElement.append(
      `<option value='${teacher.id_professor}'>${teacher.nome}</option>`
    );
  });
};

const getAllCards = async () => {
  const curso = jQuery("#select-filtro-curso").val();
  const num_aula = jQuery("#select-filtro-num-aula").val();
  const professor = jQuery("#select-filtro-professor").val();
  const ordenar = jQuery("#select-filtro-ordenar-por").val();
  const ordenar_sentido = jQuery("#select-filtro-ordenar-sentido").val();
  const response = await fetch(
    `${URL_BASE}/cards/${curso}/${num_aula}/${professor}/${ordenar}/${ordenar_sentido}`
  );
  const cards = await response.json();

  return cards;
};

const getCardsByFilters = async () => {
  getAllCards().then((data) => {
    jQuery("#cards-demanda").html("");
    jQuery("#cards-material-recebido").html("");
    jQuery("#cards-em-conferencia").html("");
    jQuery("#cards-conferido").html("");
    resetNumberStatusColumn();
    fillCards(data.cards);
    fillNumberStatusColumn(data.quantidade_status);
  });
};

const fillCards = (cards) => {
  if (cards.length > 0) {
    cards.forEach((card) => {
      if (card.id_curso != null) {
        fillCardModel1(card);
      } else {
        fillCardModel2(card);
      }
    });
  }
};

const fillNumberClassesFilter = (numberClasses) => {
  const numberClassesElement = jQuery("#select-filtro-num-aula");
  numberClasses.forEach((numberClasses) => {
    numberClassesElement.append(
      `"<option value='${numberClasses.num_aula}'>${numberClasses.num_aula}</option>"`
    );
  });
};

const fillCardModel1 = (card) => {
  let cardModel = CARD_MODEL_1.clone();
  cardModel.removeAttr("id");
  cardModel.attr("card-id", card.id_card);

  setTeachersElementsInCards(cardModel, card.professores);

  cardModel.find(".label-num-aula").text(`A${card.num_aula}`);
  const date = new Date(card.data);
  cardModel.find(".label-ano").text(date.getFullYear());

  setIconsMaterialsElementsInCards(cardModel, card.materiais);

  cardModel.find("#next > a").attr("card-id", card.id_card);
  cardModel.find("#previous > a").attr("card-id", card.id_card);
  cardModel.find("#vizualization").attr("card-id", card.id_card);

  cardModel.find("h5").text(`${card.curso.curso}`);
  setCardStatusElement(cardModel, card.status);
};

const fillCardModel2 = (card) => {
  let cardModel = CARD_MODEL_2.clone();
  cardModel.removeAttr("id");
  cardModel.attr("card-id", card.id_card);

  setTeachersElementsInCards(cardModel, card.professores);

  cardModel.find(".label-num-aula").text(`A${card.num_aula}`);
  const date = new Date(card.data);
  cardModel.find(".label-ano").text(date.getFullYear());

  setIconsMaterialsElementsInCards(cardModel, card.materiais);

  cardModel.find("#next > a").attr("card-id", card.id_card);
  cardModel.find("#previous > a").attr("card-id", card.id_card);
  cardModel.find("#vizualization").attr("card-id", card.id_card);

  cardModel.find("h5").text("AULÃO");
  setCardStatusElement(cardModel, card.status);
};

const setTeachersElementsInCards = (cardElement, teachers) => {
  const teachersElement = cardElement.find(".wrapper-professores");
  let teacherNameElementModel = teachersElement.find("span.label");
  let teacherNameElementsArray = [];

  teachersElement.empty();

  teachers.forEach((teacher) => {
    let teacherNameElement = teacherNameElementModel.clone();
    const fullName = teacher.nome.split(" ");
    const name = `${fullName[0]} ${fullName[fullName.length - 1]}`;
    teacherNameElementsArray.push(teacherNameElement.text(name));
  });

  teachersElement.html(teacherNameElementsArray);
};

const setIconsMaterialsElementsInCards = (cardElement, materials) => {
  materials.forEach((material) => {
    cardElement
      .find(".icons")
      .append(
        `<span class="glyphicon ${material.icone}" data-toggle="tooltip" data-placement="top" title="${material.material}" style="margin-right: 6px"></span>`
      );
  });
};

const setCardStatusElement = (cardElement, status) => {
  switch (status.id_status) {
    case 1:
      cardElement.find(".actions #previous").addClass("hidden");
      cardElement.appendTo("#cards-demanda");
      break;
    case 2:
      cardElement.appendTo("#cards-material-recebido");
      break;
    case 3:
      cardElement.appendTo("#cards-em-conferencia");
      break;
    case 4:
      cardElement.find(".actions #next").addClass("hidden");
      cardElement.appendTo("#cards-conferido");
      break;
  }
};

const fillNumberStatusColumn = (statusNumbers) => {
  statusNumbers.forEach((statusNumber) => {
    switch (statusNumber.id_status) {
      case 1:
        jQuery(".coluna-demanda")
          .find(".badge-num-cards")
          .text(statusNumber.quantidade_status | 0);
        break;
      case 2:
        jQuery(".coluna-material-recebido")
          .find(".badge-num-cards")
          .text(statusNumber.quantidade_status | 0);
        break;
      case 3:
        jQuery(".coluna-em-conferencia")
          .find(".badge-num-cards")
          .text(statusNumber.quantidade_status | 0);
        break;
      case 4:
        jQuery(".coluna-conferido")
          .find(".badge-num-cards")
          .text(statusNumber.quantidade_status | 0);
        break;
    }
  });
};

const resetNumberStatusColumn = () => {
  jQuery(".coluna-demanda").find(".badge-num-cards").text(0);
  jQuery(".coluna-material-recebido").find(".badge-num-cards").text(0);
  jQuery(".coluna-em-conferencia").find(".badge-num-cards").text(0);
  jQuery(".coluna-conferido").find(".badge-num-cards").text(0);
};

const showDetailsCard = async (element) => {
  const modal = jQuery("#form-card");
  const cardId = jQuery(element).attr("card-id");

  const response = await fetch(`${URL_BASE}/card/${cardId}`, {
    mode: "cors",
    credentials: "same-origin",
    headers: {
      "Content-Type": "application/json",
    },
  });
  const data = await response.json();
  const card = data[0];
  modal.find("#data").text(card.data);
  modal.find("#hora").text(card.hora);
  modal.find("#num-aula").text(`A${card.num_aula}`);

  const date = new Date(card.data);
  modal.find("#ano").text(date.getFullYear());

  if (card.curso !== null) {
    modal.find("#curso").html(
      `<h5>
        <span class="glyphicon glyphicon-education" data-toggle="tooltip" data-placement="top" title="${card.curso.curso}" style="margin-right: 6px"></span>
        ${card.curso.curso}
      </h5>`
    );
  } else {
    modal.find("#curso").html(`<h5 class="aulao-title">AULÃO</h5>`);
  }

  modal.find("#professores").empty();
  card.professores.forEach((teacher) => {
    const fullName = teacher.nome.split(" ");
    const name = `${fullName[0]} ${fullName[fullName.length - 1]}`;
    modal.find("#professores").append(
      `<span class="label">
          <span class="glyphicon glyphicon-play" data-toggle="tooltip" data-placement="top" title="${name}" style="margin-right: 6px"></span>
          ${name}
      </span>`
    );
  });

  modal.find("#materiais").empty();
  card.materiais.forEach((material) => {
    modal.find("#materiais").append(
      `<span class="label">
          <span class="glyphicon ${material.icone}" data-toggle="tooltip" data-placement="top" title="${material.material}" style="margin-right: 6px"></span>
          ${material.material}
      </span>`
    );
  });

  modal.find("#status").html(
    `<span class="label label-${card.status.cor}">
        <span class="glyphicon glyphicon-pushpin" data-toggle="tooltip" data-placement="top" title="status" style="margin-right: 6px"></span>
        ${card.status.status}
    </span>`
  );
};

const next = async (element) => {
  const cardId = jQuery(element).attr("card-id");

  const response = await fetch(`${URL_BASE}/card/next/${cardId}`, {
    mode: "cors",
    credentials: "same-origin",
    headers: {
      "Content-Type": "application/json",
    },
  });
};
const previous = async (element) => {
  const cardId = jQuery(element).attr("card-id");

  const response = await fetch(`${URL_BASE}/card/next/${cardId}`, {
    mode: "cors",
    credentials: "same-origin",
    headers: {
      "Content-Type": "application/json",
    },
  });
};
