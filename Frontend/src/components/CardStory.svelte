<script>
  let {id, name, description, priority_id} = $props();
</script>

<div class="ag-courses_item">
  <a href="" class="ag-courses-item_link">
    <div class="ag-courses-item_bg"></div>
    <div class="ag-courses-item_title">
      {name}
    </div>
    <div class="ag-courses-item_date-box">
      Prioridad:
      <span class="ag-courses-item_date">
        {priority_id === 1 ? 'Baja' : priority_id === 2 ? 'Media' : 'Alta'}
      </span>
    </div>
  </a>
</div>

<style>
.ag-courses_item {
  margin: 0 15px 30px;
  width: 300px;
  overflow: hidden;
  border-radius: 28px;
  border: 1px solid var(--Color_Background_Second);
}
.ag-courses-item_link {
  display: block;
  padding: 30px 20px;
  color: var(--Text_Color);
  overflow: hidden;
  position: relative;
  text-decoration: none;
}

.ag-courses-item_link:hover,
.ag-courses-item_link:hover .ag-courses-item_date {
  color: var(--Color_Text_Second);
}
.ag-courses-item_link:hover .ag-courses-item_bg {
  -webkit-transform: scale(10);
  -ms-transform: scale(10);
  transform: scale(10);
}
.ag-courses-item_title {
  margin: 0 0 25px;

  overflow: hidden;

  font-weight: bold;
  font-size: 20px;
  color: var(--Text_Color);

  z-index: 2;
  position: relative;
}
.ag-courses-item_date-box {
  font-size: 18px;
  color: var(--Text_Color);
  z-index: 2;
  position: relative;
}
.ag-courses-item_date {
  font-weight: bold;
  color: var(--Color_Background_Second);

  -webkit-transition: color .5s ease;
  -o-transition: color .5s ease;
  transition: color .5s ease
}
.ag-courses-item_bg {
  height: 128px;
  width: 128px;
  background-color: var(--Color_Background_Second);
  z-index: 1;
  position: absolute;
  top: -75px;
  right: -75px;
  border-radius: 50%;
  -webkit-transition: all .5s ease;
  -o-transition: all .5s ease;
  transition: all .5s ease;
}
</style>